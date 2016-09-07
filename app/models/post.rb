class Post < ApplicationRecord
  def self.published
    Category.find_by(name: 'Post').blogs.published
  end
end
