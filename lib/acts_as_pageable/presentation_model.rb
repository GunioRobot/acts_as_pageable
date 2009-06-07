module ActsAsPageable

  module PresentationModel

    module Base
      def self.included(receiver)
        receiver.extend Console
      end

      def self.extend_object(receiver)
        receiver.extend Console
      end
    end

    module Console
      def render_pagination_references
        return "don't have any page" if self.total_pages < 1
      end
    end
      
    module Html
      def render_pagination_references(url=nil)
        #return "" if self.total_pages < 1
        #url = (url.nil? || url.empty? ? '?' : url << '&')
      end
    end

  end

end
