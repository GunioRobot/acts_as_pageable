module ActionController
  module ActsAsPageable
    module Base

      attr_accessor :allowed_paginations
      attr_accessor :pageable_model
      attr_accessor :pagination_param_name
      attr_accessor :default_paginate_settings

      def paginate
        paginate_method = ("paginate_" + get_last_allowed_pagination_choice_from_params_or_cookie).to_sym
        @pageable_model.send paginate_method, params 
      end

      def get_last_allowed_pagination_choice_from_params_or_cookie
        action_name = params[:action].to_sym
        cookie_pagination_name = ("#{controller_name}_#{action_name}_pagination").to_sym

        if ( params[@pagination_param_name].nil? || params[i@pagination_param_name].empty? ) &&
           !( cookies[cookie_pagination_name].nil? || cookies[cookie_pagination_name].empty? ) 
          pagination_choice = cookies[cookie_pagination_name].to_sym
        else
          pagination_choice = params[@pagination_param_name].to_sym 
        end

        unless @allowed_paginations[action_name].include?(pagination_choice)
          pagination_choice = @allowed_paginations[action_name].first.to_s
        end
        cookies[cookie_pagination_name] = pagination_choice
      end

    end
      
  end
end

