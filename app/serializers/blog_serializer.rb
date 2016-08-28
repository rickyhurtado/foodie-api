class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_one :category
  has_one :user
end
