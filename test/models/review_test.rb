require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test 'scope :published' do
    assert_equal Review.published.count, 1
  end
end
