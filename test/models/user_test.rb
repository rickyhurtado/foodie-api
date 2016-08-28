require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @admin = User.first
    @editor = User.second
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
