require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = blogs(:blog_3)
  end

  test "should get index" do
    get reviews_url, as: :json
    assert_response :success
  end
end
