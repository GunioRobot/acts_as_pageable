require 'test_helper'

class ActsAsPageableTest < ActiveRecord::TestCase
  fixtures :authors, :blogs, :posts
  should "return in page one," do
    page = Post.paginate!
    assert_equal 5, page.total_items
    assert_equal 2, page.total_pages
    assert_equal 2, page.next
    assert_equal 1, page.previous
    assert_equal [2], page.all_next
    assert_equal [1], page.all_previous
    assert_equal 3, page.items_per_page
    assert_equal 2, page.window_offset
    assert_equal 1, page.number
  end
end
