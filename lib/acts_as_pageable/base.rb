module ActsAsPageable

  module Base

    attr_accessor :paginate_queries

    def method_missing(method_id,*args)
      if !/^paginate_/.match(method_id.to_s) || @paginate_queries.nil? || @paginate_queries.empty?
        super
      else
        paginate_by_named_query( (method_id.to_s.gsub "paginate_","").to_sym, *args )
      end
    end

    def paginate_by_named_query(key,args={}) 
      raise ArgumentError.new("undefined key=#{key}") if key.nil? || @paginate_queries.nil? || 
        @paginate_queries.empty? || !@paginate_queries.key?(key) 
      args.nil? ? paginate!(*@paginate_queries[key]) : paginate!(args.merge(*@paginate_queries[key]))
    end

    def paginate!(options={})

      pag = options.dup
      case pag[:find].class.to_s
        when "NilClass"
          proc_find = lambda{all}
        when "Hash"
          proc_find = lambda do |offset,limit,opts|
            pag[:find][:offset] = offset
            pag[:find][:limit] = limit
            all pag[:find]
          end
        when "Proc"
          proc_find = pag[:find]
        else
          raise ArgumentError.new("unknow #{pag[:find].class}")
      end
      pag[:items] = proc_find

      case pag[:count].class.to_s
        when "NilClass"
          proc_count = lambda{count}
        when "Hash"
          proc_count = lambda{count pag[:count]}
        when "Proc"
          proc_count = pag[:count]
        else
          raise ArgumentError.new("unknow #{pag[:count].class}")
      end
      pag[:total_items] = proc_count

      pag.extend Page
    end

  end
  
end
