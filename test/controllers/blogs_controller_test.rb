require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin_user)
    AuthApiToken.create(user_id: @admin.id, token: 'authapitokenadmin')
    @user = users(:blog_user_1)
    AuthApiToken.create(user_id: @user.id, token: 'authapitokenuser')
    @blog = @user.blogs.first
    @blog_params = {
      blog: {
        body: @blog.body,
        category_id: @blog.category_id,
        title: @blog.title,
        user_id: @blog.user_id
      }
    }
    @admin_header_params = { HTTP_X_TOKEN: @admin.auth_api_tokens.last.token, HTTP_X_EMAIL: @admin.email }
    @user_header_params = { HTTP_X_TOKEN: @user.auth_api_tokens.last.token, HTTP_X_EMAIL: @user.email }
  end

  test "should get index" do
    get blogs_url, as: :json
    assert_response :success

    get blogs_url, headers: @admin_header_params, as: :json
    assert_response :success
    get blogs_url, headers: @user_header_params, as: :json
    assert_response :success

    get "#{blogs_url}?page[number]=1", headers: @admin_header_params, as: :json
    assert_response :success
    get "#{blogs_url}?page[number]=1", headers: @user_header_params, as: :json
    assert_response :success

    get "#{blogs_url}?offset=1&limit=1", as: :json
    assert_response 401
    get "#{blogs_url}?offset=1&limit=1", headers: @admin_header_params, as: :json
    assert_response :success
    get "#{blogs_url}?offset=1&limit=1", headers: @user_header_params, as: :json
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

  test "should show blogs by user" do
    get blogs_by_user_url(@blog), params: { user_id: @user.id }, as: :json
    assert_response 200
  end
end
