require 'test_helper'
require 'json'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin_user)
    AuthApiToken.create(user_id: @user.id, token: 'authapitokenadmin')
    @category = categories(:post)
    @user_header_params = { HTTP_X_TOKEN: @user.auth_api_tokens.last.token, HTTP_X_EMAIL: @user.email }
  end

  test "should get index" do
    get categories_url, headers: @user_header_params, as: :json
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: 'New Category' } }, headers: @user_header_params, as: :json
    end

    assert_response 201
  end

  test "should show category" do
    get category_url(@category), headers: @user_header_params, as: :json
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { name: @category.name } }, headers: @user_header_params, as: :json
    assert_response 200
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete category_url(@category), headers: @user_header_params, as: :json
    end

    assert_response 204
  end
end
