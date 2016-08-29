require 'test_helper'

class ActivityStreamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activity_stream = activity_streams(:one)
  end

  test "should show activity_stream" do
    get activity_stream_url(@activity_stream), as: :json
    assert_response :success
  end

  test "should update activity_stream" do
    patch activity_stream_url(@activity_stream), params: { activity_stream: { action: @activity_stream.action, blog_id: @activity_stream.blog_id, user_id: @activity_stream.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy activity_stream" do
    assert_difference('ActivityStream.count', -1) do
      delete activity_stream_url(@activity_stream), as: :json
    end

    assert_response 204
  end
end
