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
end
