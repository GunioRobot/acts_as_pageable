class Author < ActiveRecord::Base
  has_many :posts
  has_many :blogs, :through => :posts, :uniq => true
end
