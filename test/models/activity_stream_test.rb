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

  test '#self.log when action is not deleted' do
    activity = ActivityStream.first

    assert_equal activity.id, 1
  end

  test '#self.log when action is deleted' do
    @blog_create.update_attributes(status: 'draft')
    @blog_create.update_attributes(status: 'published')
    @blog_create.destroy

    activity = ActivityStream.where(blog_id: @blog_create.id, deleted: 1)

    assert_equal activity.count, 4
  end
end
