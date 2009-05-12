class Category < ActiveRecord::Base

  module PagingHasManyBlogsAssociation
    include ActiveRecord::ActsAsPageable::Base
    self.paging_named_queries = { 
      :by_author => {
        :find => lambda do |offset,limit,args| 
          _id = args[:author].nil? ? args[:author_id] : args[:author].id
          raise ArgumentError.new("undefined author id") if _id.nil?
          all(:conditions => ["author_id = ?",_id],:limit => limit, :offset => offset)
        end,
        :count => lambda do |args|
          _id = args[:author].nil? ? args[:author_id] : args[:author].id
          raise ArgumentError.new("undefined author id") if _id.nil?
          count(:conditions => ["author_id = ?",_id])
        end
      }
    }
  end
  
  has_many :blogs, :extend => PagingHasManyBlogsAssociation

end
