class ActivityStreamSerializer < ActiveModel::Serializer
  attributes :id, :author_id, :author, :blog_id, :blog_title, :category_id, :category_name, :action, :deleted

  def self.prev(id, limit)
    ActivityStream.prev(id, limit)
  end
end
