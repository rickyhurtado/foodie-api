require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reviews_url, as: :json
    assert_response :success
  end
end
