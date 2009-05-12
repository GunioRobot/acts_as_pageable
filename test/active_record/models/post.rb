class Post < ActiveRecord::Base

  belongs_to :author
  belongs_to :blog

  self.default_paginate_settings = {
    :page               => 1,
    :items_per_page     => 3, 
    :window_offset      => 1, 
    :max_items_per_page => 200, 
    :min_items_per_page => 1,
    :min_window_offset  => 1, 
    :max_window_offset  => 20
  } 

  self.paging_named_queries = {
    :by_only_active => {
      :items_per_page => 3,
      :find =>  [:all, {:conditions => ["active = ?", true]}],
      :count => [{:conditions => ["active = ?", true]}]
    },
    :by_active => {
      :items_per_page => 3,
      :find => lambda do |offset,limit,args| 
        all(:conditions => ["active = ?",args[:active]],:offset => offset, :limit => limit)
      end,
      :count => lambda do |args| 
        count(:conditions => ["active = ?",args[:active]])
      end
    }
  }

end
