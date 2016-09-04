require 'test_helper'

class ActivityStreamTest < ActiveSupport::TestCase
  setup do
    @user = users(:blog_user_1)
    @post = categories(:post)

    @blog_create = Blog.create(
      title: 'Activity Blog: Post',
      body: '<p>This blog post tests the activity actions.</p>',
      status: 'published',
      category: @post,
      user: @user
    )
  end

  test '#self.log' do
    activity = ActivityStream.first

    assert_equal activity.id, 1
  end
end
