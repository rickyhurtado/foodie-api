require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin_user)
    @editor = users(:blog_user_1)
  end

  test '#ensure_authentication_token' do
    user = User.create(email: 'new+user@example.org', password: 'passw0rd', password_confirmation: 'passw0rd')

    assert user.authentication_token.present?
  end

  test '#is_admin?' do
    assert @admin.is_admin?
    assert_not @editor.is_admin?
  end

  test '#is_editor?' do
    assert @admin.is_editor?
    assert @editor.is_editor?
  end
end
