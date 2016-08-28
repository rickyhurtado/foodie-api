class SessionsController < ApplicationController
  before_action :authenticate_user_from_token!, except: [:create]

  def create
    user = User.find_by_email(params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      # Update the token for next sign in session for security
      user.ensure_authentication_token

      data = {
        token: user.authentication_token,
        email: user.email
      }

      render json: data, status: 201 and return
    else
      render status: 401 and return
    end
  end
end
