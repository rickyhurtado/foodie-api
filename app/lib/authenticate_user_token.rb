module AuthenticateUserToken
  def self.execute request
    token = request.headers['HTTP_X_TOKEN']
    email = request.headers['HTTP_X_EMAIL']

    return User.find_by(authentication_token: token, email: email) if token && email
  end
end
