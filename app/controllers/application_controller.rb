class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include AuthenticateUserToken

  before_action :set_current_user

  protected

    def authenticate_user_from_token!
      if @current_user.nil?
        self.headers['www-authenticate'] = 'token realm="application"'
        render json: 'bad credentials', status: 401 and return
      end
    end

    def check_admin_permission!
      unless @current_user.is_admin?
        self.headers['www-authenticate'] = 'token realm="application"'
        render json: 'bad credentials', status: 401 and return
      end
    end

    def set_current_user
      @current_user ||= AuthenticateUserToken.execute request
    end
end
