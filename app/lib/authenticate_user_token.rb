module AuthenticateUserToken
  def self.execute request
    token = request.headers['HTTP_X_TOKEN']
    email = request.headers['HTTP_X_EMAIL']
    user = User.find_by(email: email);

    valid_api_token =  AuthApiToken.find_by(token: token, user_id: user.id) if token && email

    return user if valid_api_token
  end
end
