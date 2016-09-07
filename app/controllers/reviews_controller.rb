class ReviewsController < ApplicationController
  before_action :set_review, only: [:show]

  # GET /reviews
  def index
    if params[:page]
      @reviews = Review.published.page(params[:page][:number])
    else
      @reviews = Review.published.page
    end

    render json: @reviews, include: ['user', 'category']
  end

  # GET /review/1
  def show
    render json: @review
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Blog.find(params[:id])
    end
end
