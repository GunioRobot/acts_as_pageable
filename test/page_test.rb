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
    context "does not use lambda for items_per_page and items parameter" do
      context "with default settings" do
        context "requesting first page" do
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
          context "and has one item" do
            setup do
              @page = {:total_items => 1, :items => [:sym] }
              @page.extend ActsAsPageable::Page
            end
            should_be_equal(
              :number          => 1, 
              :next            => 1,
              :previous        => 1, 
              :total_items     => 1, 
              :total_pages     => 1,
              :left_neighbors  => [],
              :right_neighbors => [],
              :items_per_page  => 5,
              :window_offset   => 5,
              :items           => [:sym])
          end
          context "and has 100 items" do
            setup do
              @items = (1..100).to_a 
              @page = {:total_items => @items.size, :items => @items}
              @page.extend ActsAsPageable::Page
            end
            should_be_equal(
              :number          => 1, 
              :next            => 2,
              :previous        => 1, 
              :total_items     => 100, 
              :total_pages     => 20,
              :left_neighbors  => [],
              :right_neighbors => [2,3,4,5,6],
              :items_per_page  => 5,
              :window_offset   => 5,
              :items           => (1..5).to_a)
          end
        end#requesting first page
        context "requesting nonexistent page" do
          context "(page =>2), and is empty" do
            setup do
               @page = {:total_items => 0, :page => 2} 
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
          context "(page => 0), and has one item" do
            setup do
              @items = [:sym]
              @page = {:total_items => @items.size, :items => @items ,:page => 0}
              @page.extend ActsAsPageable::Page
            end
            should_be_equal(
              :number          => 1, 
              :next            => 1,
              :previous        => 1, 
              :total_items     => 1, 
              :total_pages     => 1,
              :left_neighbors  => [],
              :right_neighbors => [],
              :items_per_page  => 5,
              :window_offset   => 5,
              :items           => [:sym])
          end
          context "(page = -1), and has 100 items" do
            setup do
              @items = (1..100).to_a 
              @page = {:total_items => @items.size, :items => @items, :page => -1}
              @page.extend ActsAsPageable::Page
            end
            should_be_equal(
              :number          => 1, 
              :next            => 2,
              :previous        => 1, 
              :total_items     => 100, 
              :total_pages     => 20,
              :left_neighbors  => [],
              :right_neighbors => [2,3,4,5,6],
              :items_per_page  => 5,
              :window_offset   => 5,
              :items           => (1..5).to_a)
          end
        end#requesting nonexistent page
        context "requesting second page" do
          context "and has 100 items" do
            setup do
              @items = (1..100).to_a 
              @page = {:total_items => @items.size, :items => @items, :page => 2}
              @page.extend ActsAsPageable::Page
            end
            should_be_equal(
              :number          => 2, 
              :next            => 3,
              :previous        => 1, 
              :total_items     => 100, 
              :total_pages     => 20,
              :left_neighbors  => [1],
              :right_neighbors => [3,4,5,6,7],
              :items_per_page  => 5,
              :window_offset   => 5,
              :items           => (6..10).to_a)
          end#and has 100 items
        end#requesting second page
        context "requesting middle page" do
          context "(page => 10) and has 100 items" do
            setup do
              @items = (1..100).to_a 
              @page = {:total_items => @items.size, :items => @items, :page => 10}
              @page.extend ActsAsPageable::Page
            end
            should_be_equal(
              :number          => 10, 
              :next            => 11,
              :previous        => 9, 
              :total_items     => 100, 
              :total_pages     => 20,
              :left_neighbors  => [5,6,7,8,9],
              :right_neighbors => [11,12,13,14,15],
              :items_per_page  => 5,
              :window_offset   => 5,
              :items           => (46..50).to_a)
          end#and has 100 items
        end#requesting middle page
        context "requesting last page" do
          context "(page = 20), and has 100 items" do
            setup do
              @items = (1..100).to_a 
              @page = {:total_items => @items.size, :items => @items, :page => 20}
              @page.extend ActsAsPageable::Page
            end
            should_be_equal(
              :number          => 20, 
              :next            => 20,
              :previous        => 19, 
              :total_items     => 100, 
              :total_pages     => 20,
              :left_neighbors  => [15,16,17,18,19],
              :right_neighbors => [],
              :items_per_page  => 5,
              :window_offset   => 5,
              :items           => (96..100).to_a)
          end#and has 100 items
        end
      end#with default settings

      context "without default settings" do
        
      end#without default settings

    end#does not use lambdas"

  end#A page instance when

end
