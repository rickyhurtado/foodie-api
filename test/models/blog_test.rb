require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  setup do
    @published_at = Time.zone.now + 2.days
    @user = users(:blog_user_1)
    @post = categories(:post)
    @blog_create_published = Blog.create(
      title: '<h1>Activity Blog: Post</h1>',
      body: '<p>This blog post <em>tests</em> the <code>activity actions</code>.</p>',
      status: 'published',
      category: @post,
      user: @user
    )
    @blog_create_with_published_date = Blog.create(
      title: 'Activity Blog: Post',
      body: '<p>This blog post tests the activity actions.</p>',
      status: 'published',
      category: @post,
      published_at: @published_at,
      user: @user
    )
    @blog_create_draft = Blog.create(
      title: 'Activity Blog: Post',
      body: '<p>This blog post tests the activity actions.</p>',
      status: 'draft',
      category: @post,
      user: @user
    )

  end

  test 'scope :published' do
    assert_equal Blog.published.count, 8
  end

  test 'scope :draft' do
    assert_equal Blog.draft.count, 4
  end

  test 'scope :published_by_user' do
    assert_equal Blog.published_by_user(@user.id).count, 5
  end

  test '#sanitize_content' do
    assert_equal @blog_create_published.title, 'Activity Blog: Post'
    assert_equal @blog_create_published.body, '<p>This blog post <em>tests</em> the activity actions.</p>'
  end

  test '#set_published_at' do
    assert @blog_create_published.published_at.present?
    assert_equal @blog_create_published.published_at.to_s, @blog_create_published.created_at.to_s
    assert @blog_create_with_published_date.published_at.present?
    assert_equal @blog_create_with_published_date.published_at.to_s, @published_at.to_s
  end

  test '#log_activity_create' do
    activity = ActivityStream.find_by(blog_id: @blog_create_draft.id)
    assert_equal activity.action, 'created'

    activity = ActivityStream.find_by(blog_id: @blog_create_published.id)
    assert_equal activity.action, 'published'
  end

  test '#log_activity_update' do
    blog_update = Blog.find(@blog_create_draft.id).update_attributes(title: 'Activity Blog: Updated Post')
    activity = ActivityStream.find_by(blog_id: @blog_create_draft.id)
    assert_equal activity.action, 'updated'

    blog_update = Blog.find(@blog_create_draft.id).update_attributes(status: 'published')
    activity = ActivityStream.find_by(blog_id: @blog_create_draft.id)
    assert_equal activity.action, 'published'

    blog_update = Blog.find(@blog_create_draft.id).update_attributes(title: 'Activity Blog: Updated Post Again')
    activity = ActivityStream.find_by(blog_id: @blog_create_draft.id)
    assert_equal activity.action, 'updated'

    blog_update = Blog.find(@blog_create_draft.id).update_attributes(status: 'draft')
    activity = ActivityStream.find_by(blog_id: @blog_create_draft.id)
    assert_equal activity.action, 'unpublished'
  end

  test '#log_activity_delete' do
    blog_destroy = Blog.find(@blog_create_published.id).destroy
    activity = ActivityStream.find_by(blog_id: @blog_create_published.id)
    assert_equal activity.action, 'deleted'
  end
end
