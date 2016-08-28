class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true

  def is_admin?
    self.role.eql?('admin')
  end

  def is_editor?
    self.role.eql?('editor') || is_admin?
  end
end
