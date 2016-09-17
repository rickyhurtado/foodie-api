class PostsController < ApplicationController
  # GET /posts
  def index
    get_all_published_posts

    render json: @blogs, include: ['user', 'category']
  end

  private

    def get_all_published_posts
      if params[:page]
        @blogs = Blog.all_published_by_category('Post', current_user_id).page(params[:page][:number])
      else
        @blogs = Blog.all_published_by_category('Post', current_user_id).page
      end
    end
end
