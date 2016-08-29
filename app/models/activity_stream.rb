class ActivityStream < ApplicationRecord
  default_scope { order('created_at DESC') }

  scope :recent, -> (limit) do
    order_desc_limit(limit)
  end

  scope :live, -> (id) do
    where('id > ?', id).order('created_at DESC')
  end

  scope :prev, -> (id, limit) do
    where('id < ?', id).order('created_at DESC').limit(limit)
  end
end
