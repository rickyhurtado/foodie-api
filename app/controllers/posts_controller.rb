class PostsController < ApplicationController
  # GET /posts
  def index
    if params[:page]
      @posts = Post.published.page(params[:page][:number])
    else
      @posts = Post.published.page
    end

    render json: @posts, include: ['user', 'category']
  end
end
