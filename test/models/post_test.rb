require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'scope :published' do
    assert_equal Post.published.count, 3
  end
end
