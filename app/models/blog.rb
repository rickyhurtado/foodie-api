class Blog < ApplicationRecord
  default_scope { order('created_at DESC') }

  belongs_to :category
  belongs_to :user
end
