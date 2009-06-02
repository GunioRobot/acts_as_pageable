module ActsAsPageable
  module Test
    module Unit
      module TestCase
        def should_be_equal(expected)
          should "return #{expected[:total_items]} for total items" do
            assert_equal(expected[:total_items], @page.total_items)
          end
          should "return #{expected[:total_pages]} for total pages" do
            assert_equal(expected[:total_pages], @page.total_pages )
          end
          should "return #{expected[:next]} for next page number" do
            assert_equal(expected[:next], @page.next)
          end
          should "return #{expected[:previous]} for previous page number" do
            assert_equal(expected[:previous], @page.previous)
          end
          should "return #{expected[:right_neighbors]} for right neighbors page numbers" do
            assert_equal(expected[:right_neighbors], @page.right_neighbors)
          end
          should "return #{expected[:left_neighbors]} for left neighbors page numbers" do
            assert_equal(expected[:left_neighbors], @page.left_neighbors)
          end
          should "return #{expected[:items_per_page]} for items per page" do
            assert_equal(expected[:items_per_page], @page.items_per_page)
          end
          should "return #{expected[:window_offset]} for window offset" do
            assert_equal(expected[:window_offset], @page.window_offset)
          end
          should "return #{expected[:number]} for current page number" do
            assert_equal(expected[:number], @page.number)
          end
          should "return #{expected[:items]} for items" do
            assert_equal(expected[:items], @page.items)
          end
        end
      end
    end
  end
end
