require File.join(File.dirname(__FILE__), 'test_helper')

class TestClass 
  attr_accessor :n
  def initialize(n)
    self.n =n 
  end
end

class ArrayTest < Test::Unit::TestCase
  
  extend ::ActsAsPageable::Test::Unit::TestCase

  context "A array when paginate" do
    setup do
      @array = []
      @array.extend ::ActsAsPageable::Paginator
      (1..6).each { |n| @array << TestClass.new(:n => n) }
    end
    context "with global settings" do
      setup do
        @page = @array.paginate!
      end
      should_be_equal (
        :number => 1, 
        :next => 2,
        :previous => 1,
        :total_items => 6, 
        :total_pages => 6,
        :left_neighbors => [1],
        :right_neighbors => [2,3],
        :items_per_page => 1,
        :window_offset => 2,
        :items => [TestClass.new(:n => 1)] ) 
    end
  end

end
