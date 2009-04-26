module ActsAsPageable

  module NamedQueries 

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
    
  end
  
end
