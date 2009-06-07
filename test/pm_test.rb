require File.join(File.dirname(__FILE__), 'test_helper')

class PmTest < Test::Unit::TestCase
  extend ActsAsPageable::Test::Unit::TestCase

  def test_a
    @page = {:total_items => 1} 
    @page.extend ActsAsPageable::Page
    @page.extend ActsAsPageable::PresentationModel::Base
    puts @page.render_pagination_references
  end

end
