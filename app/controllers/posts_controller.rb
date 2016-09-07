class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  def index
    if params[:page]
      @posts = Post.published.page(params[:page][:number])
    else
      @posts = Post.published.page
    end

    render json: @posts, include: ['user', 'category']
  end

  # GET /posts/1
  def show
    render json: @post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Blog.find(params[:id])
    end
end
