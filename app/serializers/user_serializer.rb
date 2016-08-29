class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :role

  def full_name
    [self.object.first_name, self.object.last_name].join(' ')
  end
end
