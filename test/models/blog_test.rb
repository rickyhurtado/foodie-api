require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  setup do
    @user = users(:blog_user_1)
    @post = categories(:post)

    @blog_create = Blog.create(
      title: 'Activity Blog: Post',
      body: '<p>This blog post tests the activity actions.</p>',
      category: @post,
      user: @user
    )
    @blog_update = Blog.find(@blog_create.id).update_attributes(
      title: 'Activity Blog: Post [updated]',
      body: '<p>This is activity blog post body is updated.</p>',
      category: @post,
      user: @user
    )
    @blog_destroy = Blog.destroy(@blog_create.id)
  end

  test '#log_activity_create' do
    activity = ActivityStream.third

    assert_equal activity.blog_id, @blog_create.id.to_s
    assert_equal activity.action, 'create'
  end

  test '#log_activity_update' do
    activity = ActivityStream.second

    assert_equal activity.blog_id, @blog_create.id.to_s
    assert_equal activity.action, 'update'
  end

  test '#log_activity_delete' do
    activity = ActivityStream.first

    assert_equal activity.blog_id, @blog_create.id.to_s
    assert_equal activity.action, 'delete'
  end
end
