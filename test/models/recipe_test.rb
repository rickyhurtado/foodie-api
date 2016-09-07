require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test 'scope :published' do
    assert_equal Recipe.published.count, 2
  end
end
