class Review < ApplicationRecord
  def self.published
    Category.find_by(name: 'Review').blogs.published
  end
end
