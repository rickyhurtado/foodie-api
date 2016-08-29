class UsersController < ApplicationController
  before_action :authenticate_user_from_token!, except: [:update, :destroy]
  before_action :check_admin_permission!, except: [:update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    if params[:page]
      @users = User.page(params[:page][:number])
    else
      @users = User.page
    end

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
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
    if @current_user.is_admin? || @current_user.eql?(@user)
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
    if @current_user.is_admin? || @current_user.eql?(@user)
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
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :role)
    end
end
