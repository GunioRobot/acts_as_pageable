module ActiveRecord
  module ActsAsPageable

    module PaginatorCache

      include ::ActiveRecord::ActsAsPageable::Paginator
      alias_method :paginate_without_cache, :paginate!

      MAX_PAGES_CACHE = 20

      def paging_named_queries=(queries)
        @paging_named_queries = queries
        @paging_named_queries.keys.each do | key |
          cache = @paging_named_queries[key][:cache]
          next unless cache && cache[:active]
          cache[:key] = cache[:key] ? cache[:key] + key : key
          next unless cache[:expires_on]
          cache[:expires_on].each do |callback|
            send callback do
              CACHE.delete("paginate/#{name}/#{cache[:key]}/total_items")
              max_pages ||= cache[:max_page] || MAX_PAGES_CACHE
              max_pages.times do |n|
                CACHE.delete("paginate/#{name}/#{cache[:key]}/#{n+1}")
              end
            end
          end
        end
      end

      def paginate!(options={})
        page = paginate_without_cache(options) 
        return page unless options[:cache] && options[:cache][:active]
        page.extend CacheablePage
      end

    end

    module CacheablePage

      attr_reader :key
      attr_accessor :max_page_cache
      alias_method :total_items_without_cache, :total_items
      alias_method :items_without_cache, :items

      def key
        return @key unless @key.nil?
        partial_key = fetch(:cache).fetch :key
        @key = "paginate/#{name}/#{partial_key}"
      end

      def total_items
        CACHE.fetch("#{key}/total_items") do
          total_items_without_cache
        end
      end

      def items
        max_page_to_cache = fetch(:cache).fetch :max_page, MAX_PAGES_CACHE 
        items_without_cache if number > max_page_to_cache
        CACHE.fetch("#{key}/#{number}") do 
          items_without_cache
        end
      end

    end

  end
end
