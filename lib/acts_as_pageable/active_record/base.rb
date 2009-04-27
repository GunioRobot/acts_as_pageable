module ActiveRecord
  module ActsAsPageable

    module Base

      def self.included(receiver)
        receiver.extend Paginator
      end

      def self.extend_object(receiver)
        receiver.extend Paginator
      end
     
    end

  end
end
