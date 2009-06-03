require File.join(File.dirname(__FILE__), 'active_record_test_helper')

class PostTest < Test::Unit::TestCase
  extend ActsAsPageable::Test::Unit::TestCase
  
  context "A page of post instance" do
    setup do
      [1,2].each do |author_number|
        a = Author.create(:name => author_number.to_s)
        [1,2].each do |blog_number|
          b = Blog.create(:title => "Blogs #{blog_number}")
          [0].each do |post_number|
            Post.create(:title => "Post #{post_number}", :text => "Mimimi #{post_number}", :author => a, :blog => b)
          end
        end
      end
    end
    teardown do 
      Post.delete_all
      Blog.delete_all
      Author.delete_all
    end
    context "requesting all pots" do
      setup do
        @page = Post.paginate!(:page => 2,:window_offset => 3,:items_per_page => 1,:min_items_per_page=>1,:min_window_offset=>1)
      end
      should_be_equal(
      :number          => 2, 
      :next            => 3,
      :previous        => 1,
      :total_items     => 4, 
      :total_pages     => 4,
      :left_neighbors  => [1],
      :right_neighbors => [3,4],
      :items_per_page  => 1,
      :window_offset   => 3,
      :items           => [])
    end
  end
end
