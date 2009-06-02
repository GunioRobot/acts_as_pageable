require File.join(File.dirname(__FILE__), 'test_helper')

class PageTest < Test::Unit::TestCase
  extend ActsAsPageable::Test::Unit::TestCase

  context "A page instance when" do

    context "is empty" do
      setup do
        @page = {} 
        @page.extend ActsAsPageable::Page
      end
      should "raise an Error for total pages" do
        assert_raise(ArgumentError) do
          @page.total_pages 
        end
      end
      should "raise an Error for total items" do
        assert_raise(ArgumentError) do
          @page.total_items 
        end
      end
      should "raise an Error for next page number" do
        assert_raise(ArgumentError) do 
          @page.next 
        end
      end
      should "raise an Error for previous page number" do
        assert_raise(ArgumentError) do
          @page.previous 
        end
      end
      should "raise an Error for current page number" do
        assert_raise(ArgumentError) do 
          @page.number 
        end
      end
      should "raise an Error for right neighbors page number" do
        assert_raise(ArgumentError) do 
          @page.right_neighbors 
        end
      end
      should "raise an Error for left neighbors page number" do
        assert_raise(ArgumentError) do 
          @page.left_neighbors 
        end
      end
      should "raise an Error for items" do
        assert_raise(ArgumentError) do
          @page.left_neighbors 
        end
      end
    end #is empty

    context "only total_items option is defined" do
      context "and is empty" do
       setup do
          @page = {:total_items => 0} 
          @page.extend ActsAsPageable::Page
       end
       should_be_equal(
       :number          => 0, 
       :next            => 0,
       :previous        => 0, 
       :total_items     => 0, 
       :total_pages     => 0,
       :left_neighbors  => [],
       :right_neighbors => [],
       :items_per_page  => 5,
       :window_offset   => 5,
       :items           => [])  
      end
    end

  end

end
