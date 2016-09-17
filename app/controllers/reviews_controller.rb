class ReviewsController < ApplicationController
  # GET /reviews
  def index
    get_all_published_reviews

    render json: @blogs, include: ['user', 'category']
  end

  private

    def get_all_published_reviews
      if params[:page]
        @blogs = Blog.all_published_by_category('Review', current_user_id).page(params[:page][:number])
      else
        @blogs = Blog.all_published_by_category('Review', current_user_id).page
      end
    end
end
