require File.join(ROOT_PAGEABLE_PATH, 'active_pack', 'action_controller', 'base')

ActionController::Base.extend(ActionController::ActAsPageable::Base) unless ActionController::Base.respond_to? :get_last_allowed_pagination_choice_from_params_or_cookie

