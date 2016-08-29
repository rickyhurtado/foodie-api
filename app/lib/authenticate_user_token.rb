module AuthenticateUserToken
  def self.execute request
    token = request.headers.env['HTTP_AUTHORIZATION']
    return User.find_by(authentication_token: token)
  end
end
