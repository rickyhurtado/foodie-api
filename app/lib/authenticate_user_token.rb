module AuthenticateUserToken
  def self.execute request
    token = request.headers.env['HTTP_AUTHORIZATION']
    email = request.headers.env['HTTP_EMAIL']

    return User.find_by(authentication_token: token, email: email)
  end
end
