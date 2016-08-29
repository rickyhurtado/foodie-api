class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_one :category, embed: :id, serializer: CategorySerializer, include: true
  has_one :user, embed: :id, serializer: UserSerializer, include: true
end
