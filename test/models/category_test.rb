require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'get all categories' do
    categories = Category.all

    assert categories.count.eql?(3)
  end
end
