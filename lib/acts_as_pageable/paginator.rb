module ActsAsPageable

  module Paginator
    
    include GlobalSettings

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
        self
      when "Proc"
        pag[:find]
      else
        lambda do |offset,limit,opts|
          find *pag[:find]
        end
      end
      pag[:total_items] = case pag[:count].class.to_s
      when "Proc"
        pag[:count]
      else
        size
      end
      pag.extend Page

    end
    
  end
  
end
