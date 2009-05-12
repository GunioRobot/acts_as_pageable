require 'rubygems'
require 'test/unit'

TEST_ROOT = File.expand_path(File.dirname(__FILE__))
LIB_ROOT  = File.join(File.dirname(__FILE__), '..', 'lib')

$LOAD_PATH.unshift(LIB_ROOT)
$LOAD_PATH.unshift(File.dirname(__FILE__))

class Test::Unit::TestCase

  def assert_page(expected_page,actual_page)
    assert_equal expected_page[:total_items], actual_page.total_items 
    assert_equal expected_page[:total_pages], actual_page.total_pages
    assert_equal( expected_page[:next], actual_page.next )
    assert_equal expected_page[:previous], actual_page.previous 
    assert_equal expected_page[:right_neighbors], actual_page.right_neighbors
    assert_equal expected_page[:left_neighbors], actual_page.left_neighbors 
    assert_equal expected_page[:items_per_page], actual_page.items_per_page
    assert_equal expected_page[:window_offset], actual_page.window_offset
    assert_equal expected_page[:number], actual_page.number
    assert_equal expected_page[:items], actual_page.items
  end

end
