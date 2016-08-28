require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should respond 201 for valid email and password" do
    post user_session_url, params: { user: { email: 'admin+user@example.org', password: 'passw0rd' } }, as: :json

    assert_response 201
  end

  test "should respond 401 for invalid email or password" do
    post user_session_url, params: { user: { email: 'admin+user@example.org', password: 'password' } }, as: :json

    assert_response 401
  end
end
