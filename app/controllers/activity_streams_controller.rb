class ActivityStreamsController < ApplicationController
  include ActionController::Live

  before_action :set_activity_stream, only: [:show]
  before_action :set_prev_activity_stream, only: [:prev]

  # GET /activity_streams/:id
  def show
    response.headers['Content-Type'] = 'text/event-stream'
    response.stream.write "event: activity-stream\n"
    response.stream.write "data: #{render json: @activity_stream}'\n\n"

    rescue IOError
      logger.info 'Stream closed'
    ensure
      response.stream.close
  end

  def prev
    render json: @activity_stream
  end

  private
    # Only allow a trusted parameter "white list" through.
    def activity_stream_params
      params.require(:activity_stream).permit(:activity_stream_id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_activity_stream
      if params[:id].eql?(0)
        @activity_stream = ActivityStream.recent(20)
      else
        @activity_stream = ActivityStream.live(activity_stream_params[:id])
      end
    end

    def set_prev_activity_stream
      @activity_stream = ActivityStream.prev(activity_stream_params[:id], 10)
    end
end
