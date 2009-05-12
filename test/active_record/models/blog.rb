class Blog < ActiveRecord::Base
  has_many :posts
  has_many :authors, :through => :posts, :uniq => true
  belongs_to :category
end
