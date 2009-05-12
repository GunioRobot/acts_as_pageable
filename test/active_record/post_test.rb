require File.join(File.dirname(__FILE__), 'active_record_test_helper')

class PostTest < Test::Unit::TestCase

  def setup 
    2.times do |author_number|
      a = Author.create :name => author_number.to_s
      2.times do |blog_number|
        b = a.blogs.create :title => "Blogs #{blog_number}"
        1.times do |post_number|
           b.posts.create :title => "Post #{post_number}", :text => "Mimimi #{post_number}", :author => a
        end
      end
    end
  end

  def teardown
    Post.delete_all
    Blog.delete_all
    Author.delete_all
  end

  def test_default_paging_arguments
    expected_page = {
      :number => 1, 
      :next => 2,
      :previous => 1,
      :total_items => 8, 
      :total_pages => 8,
      :left_neighbors => [1],
      :right_neighbors => [2],
      :items_per_page => 1,
      :window_offset => 1,
      :items => [Post.first]
    }
    assert_page expected_page,Post.paginate!
  end

  def test_second_page
    expected_page = {
      :number => 2, 
      :next => 3,
      :previous => 1,
      :total_items => 8, 
      :total_pages => 8,
      :left_neighbors => [1],
      :right_neighbors => [3,4,5],
      :items_per_page => 1,
      :window_offset => 3,
      :items => [Post.all[1]]
    }
    assert_page expected_page,Post.paginate!(:page => 2,:window_offset => 3)
  end

  def test_last_page
    expected_page = {
      :number => 3, 
      :next => 3,
      :previous => 2,
      :total_items => 8, 
      :total_pages => 3,
      :left_neighbors => [2],
      :right_neighbors => [3],
      :items_per_page => 3,
      :window_offset => 1,
      :items => Post.all[6..7]
    }
    assert_page expected_page,Post.paginate!(:page => 3,:items_per_page => 3)
  end

  def test_items_per_page
    expected_page = {
      :number => 1, 
      :next => 2,
      :previous => 1,
      :total_items => 8, 
      :total_pages => 2,
      :left_neighbors => [1],
      :right_neighbors => [2],
      :items_per_page => 6,
      :window_offset => 5,
      :items => Post.all[0..5]
    }
    assert_page expected_page,Post.paginate!(:items_per_page => 6,:window_offset => 5)
  end

  def test_paginate_by_active
    expected_page = {
      :number => 0, 
      :next => 0,
      :previous => 1,
      :total_items => 0, 
      :total_pages => 0,
      :left_neighbors => [1],
      :right_neighbors => [0],
      :items_per_page => 3,
      :window_offset => 1,
      :items => []
    }
    assert_page expected_page, Post.paginate_by_active(:active => false)
  end

  def test_paginate_only_active
    expected_page = {
      :number => 1, 
      :next => 2,
      :previous => 1,
      :total_items => 8, 
      :total_pages => 3,
      :left_neighbors => [1],
      :right_neighbors => [2],
      :items_per_page => 3,
      :window_offset => 1,
      :items => Post.all[0..2]
    }
    assert_page expected_page, Post.paginate_by_only_active
  end

end
