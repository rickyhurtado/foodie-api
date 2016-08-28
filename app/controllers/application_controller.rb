class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

    def authenticate_user_from_token!
      token = request.headers.env['HTTP_AUTHORIZATION']
      @user = User.find_by(authentication_token: token)

      if @user.nil?
        self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: 'Bad credentials', status: 401 and return
      end
    end
end
