class Recipe < ApplicationRecord
  def self.published
    Category.find_by(name: 'Recipe').blogs.published
  end
end
