class ActivityStream < ApplicationRecord
  default_scope { order('created_at DESC') }

  scope :recent, -> (limit) do
   limit(limit)
  end

  scope :live, -> (id) do
    where('id > ?', id)
  end

  scope :prev, -> (id, limit) do
    where('id < ?', id).limit(limit)
  end

  def self.log(blog, action)
    user = blog.user
    full_name = [user.first_name, user.last_name].join(' ')

    self.create(
      author_id: user.id,
      author: full_name,
      blog_id: blog.id,
      blog_title: blog.title,
      category_id: blog.category.id,
      category_name: blog.category.name,
      action: action
    )
  end
end
