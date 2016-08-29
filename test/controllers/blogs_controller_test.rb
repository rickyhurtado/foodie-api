require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.second
    @blog = @user.blogs.first
  end

  test "should get index" do
    get blogs_url, as: :json
    assert_response :success
  end

  test "should create blog" do
    assert_difference('Blog.count') do
      post blogs_url, params: @blog_params, headers: @user_header_params, as: :json
    end

    assert_response 201
  end

  test "should show blog" do
    get blog_url(@blog), headers: @user_header_params, as: :json
    assert_response :success
  end

  test "should update blog" do
    patch blog_url(@blog), params: @blog_params, headers: @user_header_params, as: :json
    assert_response 200
  end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete blog_url(@blog), headers: @user_header_params, as: :json
    end

    assert_response 204
  end
end
