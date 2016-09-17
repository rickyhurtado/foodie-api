class BlogsController < ApplicationController
  before_action :authenticate_user_from_token!, except: [:index, :show, :by_user]
  before_action :set_blog, only: [:show, :update, :destroy]

  # GET /blogs
  def index
    if get_all_published_blogs.eql?('Unauthorized')
      render status: 401
    else
      render json: @blogs, include: ['user', 'category']
    end
  end

  # GET /blogs/1
  def show
    if get_blog
      render json: @blog, include: ['user', 'category']
    else
      render status: 404 and return
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
    get_all_published_blogs_by_user

    render json: @blogs, include: ['user', 'category']
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blog_params
      return params.require(:blog).permit(:title, :body, :category_id, :user_id) if ENV['RAILS_ENV'].eql?('test')

      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end

    def get_all_published_blogs
      if params[:offset] && params[:limit]
        get_all_published_blogs_for_authorized_user
      else
        get_all_published_blogs_for_guest_user
      end
    end

    def get_all_published_blogs_for_authorized_user
      if @current_user
        get_all_published_blogs_for_admin_user
      else
        'Unauthorized'
      end
    end

    def get_all_published_blogs_for_admin_user
      if @current_user.is_admin?
        @blogs = Blog.page(params[:offset]).per(params[:limit])
      else
        @blogs = Blog.by_user(@current_user.id).page(params[:offset]).per(params[:limit])
      end
    end

    def get_all_published_blogs_for_guest_user
      if params[:page]
        @blogs = Blog.all_published(current_user_id).page(params[:page][:number])
      else
        @blogs = Blog.all_published(current_user_id).page
      end
    end

    def get_blog
      if params[:_]
        @blog = Blog.get_blog(params[:id], current_user_id).first
      else
        get_blog_for_admin_page
      end
    end

    def get_blog_for_admin_page
      user = User.find(@blog.user_id)

      if current_user_has_access?(user)
        @blog
      else
        render json: 'not found', status: 404 and return
      end
    end

    def get_all_published_blogs_by_user
      if params[:page]
        @blogs = Blog.all_published_by_user(params[:user_id].to_i, current_user_id).page(params[:page][:number])
      else
        @blogs = Blog.all_published_by_user(params[:user_id].to_i, current_user_id).page
      end
    end
end
