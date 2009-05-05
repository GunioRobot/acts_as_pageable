module ActsAsPageable

  module Paginator

    @@settings = {
      :page               => 1,
      :items_per_page     => 1, 
      :window_offset      => 1, 
      :max_items_per_page => 200, 
      :min_items_per_page => 1,
      :min_window_offset  => 1, 
      :max_window_offset  => 20
    }

    def self.settings=(options)
      @@settings.merge!(options)
    end
    
    def self.settings
      @@settings
    end

    attr_accessor :default_paginate_settings
    attr_accessor :paging_named_queries

    def method_missing(method_id,*args)
      if !/^paginate_/.match(method_id.to_s) || @paging_named_queries.nil? || @paging_named_queries.empty?
        super
      else
        paginate_by_named_query( (method_id.to_s.gsub "paginate_","").to_sym, *args )
      end
    end

    def paginate_by_named_query(key,args={}) 
      raise ArgumentError.new("undefined key=#{key}") if key.nil? || @paging_named_queries.nil? || 
        @paging_named_queries.empty? || !@paging_named_queries.key?(key) 
      args.nil? ? paginate!(@paging_named_queries[key]) : paginate!(args.merge(@paging_named_queries[key]))
    end

    def paginate!(options={})

      default_options = @default_paginate_settings.nil? ? @@settings : @default_paginate_settings.merge(@@settings)
      pag = default_options.merge options

      pag[:items] = case pag[:find].class.to_s
      when "NilClass"
        lambda do |offset,limit,opts|
          entries[offset..limit]
        end
      when "Proc"
        pag[:find]
      else
        lambda do |offset,limit,opts|
          find *pag[:find]
        end
      end
      pag[:total_items] = case pag[:count].class.to_s
      when "NilClass"
        lambda{size}
      when "Proc"
        pag[:count]
      else
        lambda{size}
      end
      pag.extend Page

    end
    
  end
  
end
