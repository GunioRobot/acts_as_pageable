class Author < ActiveRecord::Base
  has_many :blogs
  has_many :posts, :through => :blogs
end
