class ActivityStreamsController < ApplicationController
  include ActionController::Live

  after_action :event_stream, only: [:index, :show]

  # GET /activity_streams
  def index
    @activity_stream = ActivityStream.recent(20)
  end

  # GET /activity_streams/:id
  def show
    @activity_stream = ActivityStream.live(params[:id])
  end

  def prev
    @activity_stream = ActivityStream.prev(params[:id], 10)
    render json: @activity_stream
  end

  private

    def event_stream
      response.headers['Content-Type'] = 'text/event-stream'
      response.stream.write "event: activity-stream\n"
      response.stream.write "data: #{render json: @activity_stream}'\n\n"

      rescue IOError
        logger.info 'Stream closed'
      ensure
        response.stream.close
    end
end
