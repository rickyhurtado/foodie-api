class SessionsController < ApplicationController
  before_action :authenticate_user_from_token!, except: [:create]

  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      # Update the token for added security on the next sign in session
      !user.ensure_authentication_token
      user = User.find(user.id)

      data = {
        token: user.authentication_token,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
        role: user.role
      }

      render json: data, status: 201 and return
    else
      render status: 401 and return
    end
  end
end
