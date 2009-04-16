require 'test_helper'

class ActsAsPageableTest < ActiveRecord::TestCase
  fixtures :authors, :blogs, :posts
  context "with default configuration" do
    context ",page one" do
      setup do
        @all_posts_page_one = Post.paginate!
      end
      should "return 5 for total items" do
        assert_equal 5, @all_posts_page_one.total_items
      end
      should "return 2 for total pages" do
        assert_equal 2, @all_posts_page_one.total_pages
      end
      should "return 2 for next page" do
        assert_equal 2, @all_posts_page_one.next
      end
      should "return 1 for previous page" do
        assert_equal 1, @all_posts_page_one.previous
      end
      should "return [2] for array of next pages numbers" do
        assert_equal [2], @all_posts_page_one.all_next
      end
      should "return [1] for array fo previous pages numbers" do
        assert_equal [1], @all_posts_page_one.all_previous
      end
      should "return 3 for items per page" do
        assert_equal 3, @all_posts_page_one.items_per_page
      end
      should "return 2 for window offset" do
        assert_equal 2, @all_posts_page_one.window_offset
      end
      should "return 1 for current page" do
        assert_equal 1, @all_posts_page_one.number
      end
    end #page one
    context ",page two" do
      setup do
        @all_posts_page_two = Post.paginate! :number => 2
      end
      should "return 5 for total items" do
        assert_equal 5, @all_posts_page_two.total_items
      end
      should "return 2 for total pages" do
        assert_equal 2, @all_posts_page_two.total_pages
      end
      should "return 2 for next page" do
        assert_equal 2, @all_posts_page_two.next
      end
      should "return 1 for previous page" do
        assert_equal 1, @all_posts_page_two.previous
      end
      should "return [2] for array of next pages numbers" do
        assert_equal [2], @all_posts_page_two.all_next
      end
      should "return [1] for array fo previous pages numbers" do
        assert_equal [1], @all_posts_page_two.all_previous
      end
      should "return 3 for items per page" do
        assert_equal 3, @all_posts_page_two.items_per_page
      end
      should "return 2 for window offset" do
        assert_equal 2, @all_posts_page_two.window_offset
      end
      should "return 2 for current page" do
        assert_equal 2, @all_posts_page_two.number
      end
    end
  end
end
