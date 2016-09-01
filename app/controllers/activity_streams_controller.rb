class ActivityStreamsController < ApplicationController
  include ActionController::Live

  SSE_RETRY = 10000;
  ACTIVITY_RECORDS_INIT_LIMIT = 20
  ACTIVITY_RECORDS_PREV_LIMIT = 10

  # GET /activity_streams
  def index
    @activity_stream = ActivityStream.recent(ACTIVITY_RECORDS_INIT_LIMIT)

    response.headers['Content-Type'] = 'text/event-stream'

    sse = SSE.new(response.stream, event: 'activity-stream')
    sse.write(@activity_stream)
  ensure
    sse.close
  end

  # GET /activity_streams/:id
  def show
    @activity_stream = ActivityStream.live(params[:id])

    response.headers['Content-Type'] = 'text/event-stream'

    sse = SSE.new(response.stream, retry: 5000, event: 'activity-stream')
    sse.write(@activity_stream)
  ensure
    sse.close
  end

  def prev
    @activity_stream = ActivityStream.prev(params[:id], ACTIVITY_RECORDS_PREV_LIMIT)
    render json: @activity_stream
  end
end
