class Blog < ActiveRecord::Base
  has_many :authors
  has_many :posts, :through => :authors
end
