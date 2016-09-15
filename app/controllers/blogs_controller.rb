class BlogsController < ApplicationController
  before_action :authenticate_user_from_token!, except: [:index, :show, :by_user]
  before_action :set_blog, only: [:show, :update, :destroy]

  # GET /blogs
  def index
    if params[:offset] && params[:limit]
      authenticate_user_from_token!

      if @current_user.is_admin?
        @blogs = Blog.page(params[:offset]).per(params[:limit])
      else
        @blogs = Blog.by_user(@current_user.id).page(params[:offset]).per(params[:limit])
      end
    else
      if params[:page]
        @blogs = Blog.published.page(params[:page][:number])
      else
        @blogs = Blog.published.page
      end
    end

    render json: @blogs, include: ['user', 'category']
  end

  # GET /blogs/1
  def show
    authenticate_user_from_token!

    unless params[:_]
      user = User.find(@blog.user_id)

      if current_user_has_access?(user)
        @blog
      else
        render json: 'not found', status: 404 and return
      end
    else
      @blog = Blog.find_by(id: params[:id], status: 'published')
    end

    if @blog
      render json: @blog, include: ['user', 'category']
    else
      render json: 'not found',  status: 404 and return
    end
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)

    if @blog.save
      render json: @blog, status: :created, location: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blogs/1
  def update
    if @blog.update(blog_params)
      render json: @blog
    else
      render json: @blog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog.destroy
  end

  # /blogs/user/1
  def by_user
    if params[:page]
      @blogs = Blog.published_by_user(params[:user_id]).page(params[:page][:number])
    else
      @blogs = Blog.published_by_user(params[:user_id]).page
    end

    render json: @blogs, include: ['user', 'category']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blog_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
