class UsersController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :check_admin_permission!
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    if params[:offset] && params[:limit]
      @users = User.page(params[:offset]).per(params[:limit]).order('id DESC')
    end

    render json: @users
  end

  # GET /users/1
  def show
    if @current_user.is_admin?
      render json: @user
    else
      render json: 'bad credentials', status: 401 and return
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @current_user.is_admin?
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: 'bad credentials', status: 401 and return
    end
  end

  # DELETE /users/1
  def destroy
    if @current_user.is_admin?
      @user.destroy
    else
      render json: 'bad credentials', status: 401 and return
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
