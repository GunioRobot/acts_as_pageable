ROOT_PAGEABLE_PATH = File.join(File.dirname(__FILE__), 'acts_as_pageable')
require File.join(ROOT_PAGEABLE_PATH, 'base')
require File.join(ROOT_PAGEABLE_PATH, 'page')

require 'active_record' unless defined? ActiveRecord::Base
ActiveRecord::Base.extend(ActsAsPageable::Base) unless ActiveRecord::Base.respond_to? :paginate!

returning([ ActiveRecord::Associations::AssociationCollection ]) { |classes|
  unless ActiveRecord::Associations::HasManyThroughAssociation.superclass == ActiveRecord::Associations::HasManyAssociation
    classes << ActiveRecord::Associations::HasManyThroughAssociation
  end
}.each do |klass|
  klass.send :include, ActsAsPageable::Base unless klass.respond_to? :paginate! 
end

