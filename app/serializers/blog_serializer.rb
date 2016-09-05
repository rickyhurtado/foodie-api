class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published_at
  belongs_to :category, embed: :id, serializer: CategorySerializer, include: true
  belongs_to :user, embed: :id, serializer: UserSerializer, include: true
end
