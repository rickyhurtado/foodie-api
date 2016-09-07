require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = blogs(:blog_3)
  end

  test "should get index" do
    get reviews_url, as: :json
    assert_response :success
  end

  test "should show review" do
    get review_url(@review), params: { id: @review.id }, as: :json
    assert_response :success
  end
end
