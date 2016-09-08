class ReviewsController < ApplicationController
  # GET /reviews
  def index
    if params[:page]
      @reviews = Review.published.page(params[:page][:number])
    else
      @reviews = Review.published.page
    end

    render json: @reviews, include: ['user', 'category']
  end
end
