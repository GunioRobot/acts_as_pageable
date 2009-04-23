require File.join(File.dirname(__FILE__), 'test_helper')

class ActsAsPageableTest < ActiveRecord::TestCase
  fixtures :authors, :blogs, :posts
  context "with default configuration" do
    context ",when request to page one of all Post," do
      setup do @page_one = Post.paginate! end
      should "return 7 for total items"   do assert_equal 7, @page_one.total_items end 
      should "return 3 for total pages"   do assert_equal 3, @page_one.total_pages end
      should "return 2 for next page"     do assert_equal 2, @page_one.next end
      should "return 1 for previous page" do assert_equal 1, @page_one.previous end
      should "return [2,3] for array of next pages numbers"   do assert_equal [2,3], @page_one.right_neighbors end
      should "return [] for array fo previous pages numbers" do assert_equal [], @page_one.left_neighbors end 
      should "return 3 for items per page" do assert_equal 3, @page_one.items_per_page end
      should "return 2 for window offset"  do assert_equal 2, @page_one.window_offset end
      should "return 1 for current page"   do assert_equal 1, @page_one.number end
    end
    context ",when request to page two of all Post," do
      setup do @page_two = Post.paginate! :page => 2 end 
      should "return 5 for total items"   do assert_equal 7, @page_two.total_items end 
      should "return 3 for total pages"   do assert_equal 3, @page_two.total_pages end 
      should "return 3 for next page"     do assert_equal 3, @page_two.next end
      should "return 1 for previous page" do assert_equal 1, @page_two.previous end 
      should "return [] for array of next pages numbers"     do assert_equal [], @page_two.right_neighbors end
      should "return [] for array fo previous pages numbers" do assert_equal [], @page_two.left_neighbors end
      should "return 3 for items per page" do assert_equal 3, @page_two.items_per_page end
      should "return 2 for window offset"  do assert_equal 2, @page_two.window_offset end
      should "return 2 for current page"   do assert_equal 2, @page_two.number end
    end 
    context ",when request to page tree of all Post," do
      setup do @page_tree = Post.paginate! :page => 3 end 
      should "return 5 for total items"   do assert_equal 7, @page_tree.total_items end 
      should "return 3 for total pages"   do assert_equal 3, @page_tree.total_pages end 
      should "return 3 for next page"     do assert_equal 3, @page_tree.next end
      should "return 2 for previous page" do assert_equal 2, @page_tree.previous end 
      should "return [] for array of next pages numbers"     do assert_equal [], @page_tree.right_neighbors end
      should "return [1,2] for array fo previous pages numbers" do assert_equal [1,2], @page_tree.left_neighbors end
      should "return 3 for items per page" do assert_equal 3, @page_tree.items_per_page end
      should "return 2 for window offset"  do assert_equal 2, @page_tree.window_offset end
      should "return 3 for current page"   do assert_equal 3, @page_tree.number end
    end
    context ",when request inexist page number," do
      context "4" do
        setup do @page_tree = Post.paginate! :page => 4 end 
        should "return 5 for total items"   do assert_equal 7, @page_tree.total_items end 
        should "return 3 for total pages"   do assert_equal 3, @page_tree.total_pages end 
        should "return 3 for next page"     do assert_equal 3, @page_tree.next end
        should "return 2 for previous page" do assert_equal 2, @page_tree.previous end 
        should "return [] for array of next pages numbers"     do assert_equal [], @page_tree.right_neighbors end
        should "return [1,2] for array fo previous pages numbers" do assert_equal [1,2], @page_tree.left_neighbors end
        should "return 3 for items per page" do assert_equal 3, @page_tree.items_per_page end
        should "return 2 for window offset"  do assert_equal 2, @page_tree.window_offset end
        should "return 3 for current page"   do assert_equal 3, @page_tree.number end
      end
      context "-1" do 
        setup do @page_one = Post.paginate! :numer => -1 end
        should "return 7 for total items"   do assert_equal 7, @page_one.total_items end 
        should "return 3 for total pages"   do assert_equal 3, @page_one.total_pages end
        should "return 2 for next page"     do assert_equal 2, @page_one.next end
        should "return 1 for previous page" do assert_equal 1, @page_one.previous end
        should "return [2,3] for array of next pages numbers"   do assert_equal [2,3], @page_one.right_neighbors end
        should "return [] for array fo previous pages numbers" do assert_equal [], @page_one.left_neighbors end 
        should "return 3 for items per page" do assert_equal 3, @page_one.items_per_page end
        should "return 2 for window offset"  do assert_equal 2, @page_one.window_offset end
        should "return 1 for current page"   do assert_equal 1, @page_one.number end
      end
      context "0" do 
        setup do @page_one = Post.paginate! :page => 0 end
        should "return 7 for total items"   do assert_equal 7, @page_one.total_items end 
        should "return 3 for total pages"   do assert_equal 3, @page_one.total_pages end
        should "return 2 for next page"     do assert_equal 2, @page_one.next end
        should "return 1 for previous page" do assert_equal 1, @page_one.previous end
        should "return [2,3] for array of next pages numbers"   do assert_equal [2,3], @page_one.right_neighbors end
        should "return [] for array fo previous pages numbers" do assert_equal [], @page_one.left_neighbors end 
        should "return 3 for items per page" do assert_equal 3, @page_one.items_per_page end
        should "return 2 for window offset"  do assert_equal 2, @page_one.window_offset end
        should "return 1 for current page"   do assert_equal 1, @page_one.number end
      end
    end
    context ",when request to page one of Blogs," do 
      setup do
        paulo = Author.find 1
        @page_one = paulo.blogs.paginate!
      end
      should "return 1 for total items"   do assert_equal 1, @page_one.total_items end
      should "return 1 for total pages"   do assert_equal 1, @page_one.total_pages end
      should "return 1 for next page"     do assert_equal 1, @page_one.next end
      should "return 1 for previous page" do assert_equal 1, @page_one.previous end
      should "return [] for array of next pages numbers"     do assert_equal [], @page_one.right_neighbors end
      should "return [] for array fo previous pages numbers" do assert_equal [], @page_one.left_neighbors end
      should "return 3 for items per page" do assert_equal 3, @page_one.items_per_page end 
      should "return 2 for window offset"  do assert_equal 2, @page_one.window_offset end
      should "return 1 for current page"   do assert_equal 1, @page_one.number end
    end
    context ",when request to page two of Blogs," do 
      setup do
        ahagon = Author.find 2 
        @page_two = ahagon.blogs.paginate!
      end
      should "return 2 for total items"   do assert_equal 2, @page_two.total_items end
      should "return 1 for total pages"   do assert_equal 1, @page_two.total_pages end
      should "return 1 for next page"     do assert_equal 1, @page_two.next end
      should "return 1 for previous page" do assert_equal 1, @page_two.previous end
      should "return [] for array of next pages numbers"     do assert_equal [], @page_two.right_neighbors end
      should "return [] for array fo previous pages numbers" do assert_equal [], @page_two.left_neighbors end
      should "return 3 for items per page" do assert_equal 3, @page_two.items_per_page end 
      should "return 2 for window offset"  do assert_equal 2, @page_two.window_offset end
      should "return 1 for current page"   do assert_equal 1, @page_two.number end
    end
  end
end
