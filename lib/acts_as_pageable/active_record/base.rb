module ActiveRecord
  module ActsAsPageable

    module Base

      include ::ActsAsPageable::NamedQueries

      def paginate!(options={})
        pag = options.dup
        pag[:items] = case pag[:find].class.to_s
          when "NilClass"
            lambda do |offset,limit,opts|
              all(:offset => offset, :limit => limit)
            end
          when "Proc"
            pag[:find]
          else
            lambda do |offset,limit,opts|
              hash = pag[:find].last
              hash[:offset] = offset
              hash[:limit] = limit
              find pag[:find]
            end
        end
        pag[:total_items] = case pag[:count].class.to_s
          when "NilClass"
            lambda{count}
          when "Proc"
            pag[:count]
          else
            lambda{count pag[:count]}
        end
        pag.extend ::ActsAsPageable::Page
      end

    end

  end
end
