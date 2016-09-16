class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }, unless: "password.nil?"
  validates :password, presence: true, if: "id.nil?"

  after_save :ensure_authentication_token

  has_many :auth_api_tokens
  has_many :blogs, dependent: :destroy

  def ensure_authentication_token
    AuthApiToken.create(user: self, token: generate_authentication_token)
  end

  def is_admin?
    self.role.downcase.eql?('admin')
  end

  def is_editor?
    self.role.downcase.eql?('editor') || is_admin?
  end

  private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless AuthApiToken.where(token: token).first
      end
    end
end
