require 'test_helper'

class ActivityStreamsControllerTest < ActionDispatch::IntegrationTest
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

  test "should show recent activities" do
    get activity_streams_url, as: :json

    assert_response :success
  end

  test "should show the upcoming activities" do
    @activity = ActivityStream.last
    get activity_stream_prev_url(@activity), as: :json

    assert_response :success
  end

  test "should previous activities on request" do
    @activity = ActivityStream.second
    get activity_stream_prev_url(@activity), as: :json

    json = YAML.load(response.body)

    assert_response :success
    assert json['data'].count.eql?(1)
  end
end
