require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  setup do
    @user_1 = users(:blog_user_1)
    @user_2 = users(:blog_user_2)
    @user_3 = users(:blog_user_3)
    @post = categories(:post)
    @published_at = Time.zone.now - 1.day
    @published_at_future = Time.zone.now + 1.day
    @blog_params = {
      title: '<h1>Activity Blog: Post</h1>',
      body: '<p>This blog post <em>tests</em> the <code>activity actions</code>.</p>',
      status: 'published',
      category: @post,
      user: @user_1
    }
    @blog_create_published = Blog.create(@blog_params)
    @blog_create_with_published_date = Blog.create(@blog_params.merge({ published_at: @published_at }))
    @blog_create_with_published_date_future = Blog.create(@blog_params.merge({ published_at: @published_at_future }))
    @blog_create_draft = Blog.create(@blog_params.merge({ published_at: @published_at_future, status: 'draft' }))
  end

  test 'scope :draft' do
    assert_equal Blog.draft.count, 4
  end

  test '#published if user is guest' do
    assert_equal Blog.all_published(nil).count, 7
  end

  test '#published if user is signed in' do
    assert_equal Blog.all_published(@user_1.id).count, 10
  end

  test '#published_by_user if user is guest' do
    assert_equal Blog.all_published_by_user(@user_1.id, nil).count, 4
  end

  test '#published_by_user if user is signed in and the owner of blogs' do
    assert_equal Blog.all_published_by_user(@user_1.id, @user_1.id).count, 7
  end

  test '#published_by_user if user is signed in and NOT the owner of blogs' do
    assert_equal Blog.all_published_by_user(@user_1.id, @user_2.id).count, 4
  end

  test '#published_by_category if user is guest' do
    assert_equal Blog.all_published_by_category('Post', nil).count, 4
    assert_equal Blog.all_published_by_category('Recipe', nil).count, 2
    assert_equal Blog.all_published_by_category('Review', nil).count, 1
  end

  test '#published_by_category if user is signed in' do
    assert_equal Blog.all_published_by_category('Post', @user_1).count, 7
    assert_equal Blog.all_published_by_category('Post', @user_2).count, 4
    assert_equal Blog.all_published_by_category('Post', @user_3).count, 4
    assert_equal Blog.all_published_by_category('Recipe', @user_1).count, 2
    assert_equal Blog.all_published_by_category('Recipe', @user_2).count, 2
    assert_equal Blog.all_published_by_category('Recipe', @user_3).count, 3
    assert_equal Blog.all_published_by_category('Review', @user_1).count, 1
    assert_equal Blog.all_published_by_category('Review', @user_2).count, 2
    assert_equal Blog.all_published_by_category('Review', @user_3).count, 2
  end

  test '#get_blog if user is guest' do
    assert Blog.get_blog(@blog_create_with_published_date.id, nil).any?
    assert Blog.get_blog(@blog_create_with_published_date_future.id, nil).empty?
    assert Blog.get_blog(@blog_create_draft.id, nil).empty?
  end

  test '#get_blog if user is signed in' do
    assert Blog.get_blog(@blog_create_with_published_date.id, @user_1.id).any?
    assert Blog.get_blog(@blog_create_with_published_date_future.id, @user_1.id).any?
    assert Blog.get_blog(@blog_create_draft.id, @user_1.id).any?

    assert Blog.get_blog(@blog_create_with_published_date.id, @user_2.id).any?
    assert Blog.get_blog(@blog_create_with_published_date_future.id, @user_2.id).empty?
    assert Blog.get_blog(@blog_create_draft.id, @user_2.id).empty?
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
