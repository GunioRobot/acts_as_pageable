module ActsAsPageable

  module Page

    include GlobalSettings

    attr_reader :total_items, :total_pages, :items
    attr_reader :next, :previous, :left_neighbors, :right_neighbors
   
    attr_accessor :items_per_page, :window_offset, :number
    attr_accessor :max_items_per_page, :min_items_per_page
    attr_accessor :min_window_offset, :max_window_offset

    def number
      @number = fetch(:page,1)
      @number = store(:page,1) if @number < 1 
      @number = store(:page,self.total_pages) if @number > self.total_pages
      @number
    end

    def number=(value)
      store(:page,value)
    end

    def max_items_per_page
      @max_items_per_page = fetch(:max_items_per_page,@@settings[:max_items_per_page])
      unless @max_items_per_page.between?(self.min_items_per_page,@@settings[:max_items_per_page])
        @max_items_per_page = store(:max_items_per_page,@@settings[:max_items_per_page])
      end 
      store(:max_items_per_page,@max_items_per_page)
    end

    def max_items_per_page=(value)
      store(:max_items_per_page,value)
    end

    def min_items_per_page
      @min_items_per_page = fetch(:min_items_per_page,@@settings[:min_items_per_page])
      unless @min_items_per_page.between?(1,@@settings[:min_items_per_page])
        @min_items_per_page = store(:min_items_per_page,@@settings[:min_items_per_page])
      end
      store(:mim_items_per_page,@min_items_per_page)
    end

    def min_items_per_page=(value)
      store(:min_items_per_page,value)
    end

    def items_per_page
      @items_per_page = fetch(:items_per_page, self.min_items_per_page)
      unless @items_per_page.between?(self.min_items_per_page, self.max_items_per_page)
        @items_per_page = store(:items_per_page,self.min_items_per_page)
      end
      store(:items_per_page,@items_per_page)
    end

    def items_per_page=(value)
      store(:items_per_page,value)
    end

    def min_window_offset
      @min_window_offset = fetch(:min_window_offset,@@settings[:min_window_offset])
      unless @min_window_offset.between?(1,@@settings[:min_window_offset])
        @min_window_offset = store(:min_window_offset,@@settings[:min_window_offset])
      end
      store(:min_window_offset,@min_window_offset)
    end

    def min_window_offset=(value)
      store(:min_window_offset,value)
    end

    def max_window_offset
      @max_window_offset = fetch(:max_window_offset,@@settings[:max_window_offset])
      unless @max_window_offset.between?(self.min_window_offset,@@settings[:max_window_offset])
        @max_window_offset = store(:max_window_offset,@@settings[:max_window_offset])
      end
      store(:max_window_offset,@max_window_offset)
    end

    def max_window_offset=(value)
      store(:max_window_offset,value)
    end

    def window_offset
      @window_offset = fetch(:window_offset,self.min_window_offset)
      unless @window_offset.between?(self.min_window_offset, self.max_window_offset)
        @window_offset = store(:window_offset,self.min_window_offset)
      end
      store(:window_offset,@window_offset)
    end

    def window_offset=(value)
      store(:window_offset,value)
    end

    def total_pages
      return @total_pages unless @total_pages.nil?
      @total_pages = store :total_pages, (self.total_items.to_f / self.items_per_page.to_f).ceil
      store(:total_pages,@total_pages)
    end
    
    def next
      return @next unless @next.nil?
      @next = self.number + 1
      @next = self.total_pages if @next > self.total_pages
      store(:next,@next)
    end

    def previous
      return @previous unless @previous.nil?
      @previous = self.number - 1
      @previous = 1 if @previous < 1
      store(:previous,@previous)
    end

    def left_neighbors
      return @left_neighbors unless @left_neighbors.nil?
      range_start = self.number - self.window_offset 
      range_start = 1 if range_start < 1 
      range_end = self.previous
      @left_neighbors = (range_start..range_end).to_a
      store(:left_neighbors,@left_neighbors)
    end

    def right_neighbors
      return @right_neighbors unless @right_neighbors.nil?
      range_start = self.next
      range_end = self.number + self.window_offset
      range_end = self.total_pages if range_end > self.total_pages
      @right_neighbors = (range_start..range_end).to_a
      store(:right_neighbors,@right_neighbors)
    end

    def total_items
      return @total_items unless @total_items.nil?
      total_items_proc = fetch(:total_items)
      @total_items = total_items_proc.call(self)
      store(:total_item,@total_items)
    end

    def items
      if self.total_items < 1
        @items = []
      else
        offset = (self.number * self.items_per_page) - self.items_per_page 
        limit = self.items_per_page
        items_proc = fetch(:items)
        @items = items_proc.call(offset,limit,self)
      end
      @items
    end

    def each(&block)
      self.items.each &block
    end
    
  end

end
