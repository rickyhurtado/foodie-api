require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin_user)
    @user = users(:blog_user_1)
    @user_params = { user: {
      id: @user.id,
      email: 'new+user@exampl.org',
      password: 'passw0rd',
      password_confirmation: 'passw0rd',
      firts_name: 'New',
      last_name: 'Blogger',
      role: 'editor' }
    }
    @admin_header_params = { AUTHORIZATION: @admin.authentication_token, EMAIL: @admin.email }
    @user_header_params = { AUTHORIZATION: @user.authentication_token, EMAIL: @user.email}
  end

  test "admin should get index" do
    get users_url, headers: @admin_header_params, as: :json
    assert_response :success
  end

  test "user should not get index" do
    get users_url, headers: @user_header_params, as: :json
    assert_response 401
  end

  test "admin should create user" do
    assert_difference('User.count') do
      post users_url, params: @user_params, headers: @admin_header_params, as: :json
    end

    assert_response 201
  end

  test "user should not create user" do
    assert_no_difference('User.count') do
      post users_url, params: @user_params, headers: @user_header_params, as: :json
    end

    assert_response 401
  end

  test "should show user to admin user" do
    get user_url(@user), headers: @admin_header_params, as: :json
    assert_response :success
  end

  test "should not show user to non admin user" do
    get user_url(@user), headers: @user_header_params, as: :json
    assert_response 401
  end

  test "admin should update user" do
    patch user_url(@user), params: @user_params, headers: @admin_header_params, as: :json
    assert_response 200
  end

  test "user should update own account" do
    patch user_url(@user), params: @user_params, headers: @user_header_params, as: :json
    assert_response 200
  end

  test "user should not update other user" do
    patch user_url(@admin), params: @user_params, headers: @user_header_params, as: :json
    assert_response 401
  end

  test "admin should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), headers: @admin_header_params, as: :json
    end

    assert_response 204
  end

  test "user should not destroy other user" do
    assert_difference('User.count', 0) do
      delete user_url(@admin), headers: @user_header_params, as: :json
    end

    assert_response 401
  end

  test "user should destroy own account" do
    assert_difference('User.count', -1) do
      delete user_url(@user), headers: @user_header_params, as: :json
    end

    assert_response 204
  end
end
