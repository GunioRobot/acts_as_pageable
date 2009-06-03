require File.join(File.dirname(__FILE__), 'test_helper')

class TestClass 
  attr_accessor :n
  def initialize(n)
    self.n =n 
  end
  def ==(other)
    equal(other)
  end
  def equal(other)
    return false if other.nil?
    return false unless other.kind_of?(TestClass)
    return other.n == self.n
  end
end

class ArrayTest < Test::Unit::TestCase
  extend ::ActsAsPageable::Test::Unit::TestCase

  context "A array when paginate" do
    setup do
      @array = []
      @array.extend ActsAsPageable::Paginator
      (1..20).each { |n| @array << TestClass.new(:n => n) }
    end
    context "with global settings" do
      setup do
        @page = @array.paginate!
      end
      should_be_equal (
        :number          => 1, 
        :next            => 2,
        :previous        => 1,
        :total_items     => 20, 
        :total_pages     => 2,
        :left_neighbors  => [],
        :right_neighbors => [2],
        :items_per_page  => 10,
        :window_offset   => 5,
        :items => [TestClass.new(:n => 1),TestClass.new(:n => 2),
                  TestClass.new(:n => 3),TestClass.new(:n => 4),
                  TestClass.new(:n => 5),TestClass.new(:n => 6),
                  TestClass.new(:n => 7),TestClass.new(:n => 8),
                  TestClass.new(:n => 9),TestClass.new(:n => 10)] ) 
    end
  end

end
