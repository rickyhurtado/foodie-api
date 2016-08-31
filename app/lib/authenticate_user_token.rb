module AuthenticateUserToken
  def self.execute request
    token = request.headers['HTTP_AUTHORIZATION']
    email = request.headers['HTTP_EMAIL']

    return User.find_by(authentication_token: token, email: email) if token && email
  end
end
