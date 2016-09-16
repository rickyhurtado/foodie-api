require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_params = {
      user: {
        email: 'admin+user@example.org',
        password: 'passw0rd'
      }
    }
  end

  test "should respond 201 for valid email and password" do
    post user_session_url, params: @user_params, as: :json

    assert_response 201
  end

  test "should respond 401 for invalid email or password" do
    @user_params[:user][:password] = 'wrongpassword'

    post user_session_url, params: @user_params, as: :json

    assert_response 401
  end
end
