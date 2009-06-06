module ActsAsPageable

  module Page

    attr_reader :total_items, :total_pages, :items
    attr_reader :next, :previous, :left_neighbors, :right_neighbors
   
    attr_accessor :items_per_page, :window_offset, :number
    attr_accessor :max_items_per_page, :min_items_per_page
    attr_accessor :min_window_offset, :max_window_offset

    def self.extend_object(receiver)
      super
      receiver.replace(GlobalSettings.settings.merge(receiver)) if receiver.respond_to?(:merge!)
    end

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
      @max_items_per_page = fetch(:max_items_per_page) if @max_items_per_page.nil?
      @max_items_per_page 
    end

    def max_items_per_page=(value)
      store(:max_items_per_page,value)
    end

    def min_items_per_page
      @min_items_per_page = fetch(:min_items_per_page) if @max_items_per_page.nil?
      @min_items_per_page
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
      @min_window_offset = fetch(:min_window_offset) if @min_window_offset.nil?
      @min_window_offset
    end

    def min_window_offset=(value)
      store(:min_window_offset,value)
    end

    def max_window_offset
      @max_window_offset = fetch(:max_window_offset) if @max_window_offset.nil?
      @max_window_offset 
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
      (@previous = self.total_items > 0 ? 1 : 0) if @previous < 1
      store(:previous,@previous)
    end

    def left_neighbors
      return [] if self.total_pages < 2 || self.number == 1
      return @left_neighbors unless @left_neighbors.nil?
      range_start = self.number - self.window_offset 
      range_start = 1 if range_start < 1
      range_end = self.previous
      @left_neighbors = (range_start..range_end).to_a
      store(:left_neighbors,@left_neighbors)
    end

    def right_neighbors
      return [] if self.total_pages < 2 || self.number == self.total_pages
      return @right_neighbors unless @right_neighbors.nil?
      range_start = self.next
      range_end = self.number + self.window_offset
      range_end =  self.total_pages if range_end > self.total_pages
      @right_neighbors = (range_start..range_end).to_a
      store(:right_neighbors,@right_neighbors)
    end

    def total_items
      return @total_items unless @total_items.nil?
      total_items_value = fetch(:total_items) { raise ArgumentError.new("undefined total_items") }
      if total_items_value.respond_to?(:call)
        @total_items = total_items_value.call(self) 
      elsif total_items_value.kind_of?(Fixnum)
        @total_items = total_items_value
      else
        raise ArgumentError.new("unknow kind of total_items #{total_items_value}")
      end
      store(:total_item,@total_items)
    end

    def items
      return [] if self.total_items < 1
      items_value = fetch(:items){ raise ArgumentError.new("undefined items") }
      if items_value.respond_to?(:call)
        offset = (self.number * self.items_per_page) - self.items_per_page 
        limit = self.items_per_page
        @items = items_value.call(offset,limit,self)
      elsif items_value.respond_to?(:[])
        start_index = (self.number * self.items_per_page) - self.items_per_page 
        end_index   = start_index + self.items_per_page - 1
        @items = items_value[start_index..end_index] 
      else
        raise ArgumentError.new("unknow kind of items #{items_value}")
      end
    end

    def each(&block)
      self.items.each &block
    end
    
  end

end
