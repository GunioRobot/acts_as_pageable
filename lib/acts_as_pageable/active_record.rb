require File.join(ROOT_PAGEABLE_PATH, 'active_record', 'paginator')
require File.join(ROOT_PAGEABLE_PATH, 'active_record', 'base')

ActiveRecord::Base.extend(ActiveRecord::ActsAsPageable::Base) unless ActiveRecord::Base.respond_to? :paginate!
returning([ ActiveRecord::Associations::AssociationCollection ]) { |classes|
  unless ActiveRecord::Associations::HasManyThroughAssociation.superclass == ActiveRecord::Associations::HasManyAssociation
    classes << ActiveRecord::Associations::HasManyThroughAssociation
  end
}.each do |klass|
  klass.send :include, ActiveRecord::ActsAsPageable::Base unless klass.respond_to? :paginate! 
end


