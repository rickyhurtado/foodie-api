class Blog < ApplicationRecord
  default_scope { order('published_at DESC') }

  belongs_to :category
  belongs_to :user

  scope :published, -> { where(status: 'published') }
  scope :draft, -> { where(status: 'draft') }
  scope :published_by_user, -> (user_id) { where(status: 'published', user_id: user_id) }

  before_create :set_published_at
  after_create :log_activity_create
  after_update :log_activity_update
  after_destroy :log_activity_delete

  private

    def set_published_at
      self.published_at ||= Time.zone.now
    end

    def log_activity_create
      if self.status.eql?('published')
        log_activity('published')
      else
        log_activity('created')
      end
    end

    def log_activity_update
      if self.status_was.eql?('draft') && self.status.eql?('published')
        log_activity('published')
      elsif self.status_was.eql?('published') && self.status.eql?('draft')
        log_activity('unpublished')
      else
        log_activity('updated')
      end
    end

    def log_activity_delete
      log_activity('deleted')
    end

    def log_activity(action)
      ActivityStream.log(self, action);
    end
end
