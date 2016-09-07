require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = blogs(:blog_1)
  end

  test "should get index" do
    get posts_url, as: :json
    assert_response :success
  end

  test "should show post" do
    get post_url(@post), params: { id: @post.id }, as: :json
    assert_response :success
  end
end
