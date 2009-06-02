require File.join(File.dirname(__FILE__), 'active_record_test_helper')

class CategoryTest < Test::Unit::TestCase

  def setup 
    java_category = Category.create :name => "Java"
    ruby_category = Category.create :name => "Ruby"
    2.times do |author_number|
      a = Author.create :name => author_number.to_s
      2.times do |blog_number|
        b = a.blogs.create :title => "Blogs #{blog_number}", :category => (blog_number % 2 == 0 ? java_category : ruby_category)
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

  def test_paging_association
    java_category = Category.first
    author = Author.first
    expected_page = {
      :number => 1, 
      :next => 2,
      :previous => 1,
      :total_items => 2, 
      :total_pages => 2,
      :left_neighbors => [1],
      :right_neighbors => [2],
      :items_per_page => 1,
      :window_offset => 1,
      :items => [Blog.all[0],Blog.all[2]]
    }
    should_be_equal expected_page,java_category.blogs.paginate_by_author(:author => author)
  end

end
