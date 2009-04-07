module ActsAsPageable

  class Page

    attr_reader :total_items, :total_pages, :items
    attr_reader :next, :previous, :all_previous, :all_next
    
    attr_accessor :items_per_page, :window_offset, :number
    attr_accessor :max_items_per_page, :min_items_per_page
    attr_accessor :min_window_offset, :max_window_offset

    def items_per_page
      @items_per_page = self.min_items_per_page if @items_per_page.nil? ||
        !@items_per_page.between?(self.min_items_per_page, self.max_items_per_page)
      @items_per_page
    end

    def window_offset
      @window_offset = self.min_window_offset if @window_offset.nil? ||
        !@window_offset.between?(self.min_window_offset, self.max_window_offset)
      @window_offset
    end

    def number
      @number = 1 if @number.nil? || @number < 1 
      @number = self.total_pages if @number > self.total_pages
      @number
    end

    def max_items_per_page
      @max_items_per_page = 5 if @max_items_per_page.nil?
      @max_items_per_page
    end

    def min_items_per_page
      @min_items_per_page = 3 if @min_items_per_page.nil?
      @min_items_per_page
    end

    def min_window_offset
      @min_window_offset = 2 if @min_window_offset.nil?
      @min_window_offset
    end

    def max_window_offset
      @max_window_offset = 3 if @max_window_offset.nil?
      @max_window_offset
    end

    def total_pages
      return @total_pages unless @total_pages.nil?
      @total_pages = (self.total_items.to_f / self.items_per_page.to_f).ceil 
      @total_pages
    end
    
    def next
      return @next unless @next.nil?
      @next = self.number + 1
      @next = self.total_pages if @next > self.total_pages
      @next
    end

    def previous
      return @previous unless @previous.nil?
      @previous = self.number - 1
      @previous = 1 if @previous < 1
      @previous
    end

    def all_previous
      return @all_previous unless @all_previous.nil?
      range_end = self.number - self.window_offset 
      range_end = 1 if range_end < 1 
      range_start = self.previous
      @all_previous = (range_start..range_end).to_a
    end

    def all_next
      return @all_next unless @all_next.nil?
      range_end = self.number + self.window_offset
      range_end = self.total_pages if range_end > self.total_pages
      range_start = self.next
      @all_next = (range_start..range_end).to_a
    end

    def initialize(args={})
      [:items_per_page=, :window_offset=, :number=,:max_items_per_page=, 
       :min_items_per_page=, :min_window_offset=, :max_window_offset=].each do |accessor|
         self.send(accessor, *args[accessor]) unless args[accessor].nil?
       end
      @total_items = args[:total_items].call(args)
      if @total_items < 1
        @items = []
      else
        offset = (self.number * self.items_per_page) - self.items_per_page 
        limit = self.items_per_page
        @items = args[:items].call(offset,limit,args)
      end
    end

  end

end
