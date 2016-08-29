class Blog < ApplicationRecord
  default_scope { order('created_at DESC') }

  belongs_to :category
  belongs_to :user

  after_create :log_activity_create
  after_update :log_activity_update
  after_destroy :log_activity_delete

  private

    def log_activity_create
      log_activity('create')
    end

    def log_activity_update
      log_activity('update')
    end

    def log_activity_delete
      log_activity('delete')
    end

    def log_activity(action)
      user = self.user
      full_name = [user.first_name, user.last_name].join(' ')

      ActivityStream.create(
        author_id: user.id,
        author: full_name,
        blog_id: self.id,
        blog_title: self.title,
        blog_category: self.category.name,
        action: action
      )
    end
end
