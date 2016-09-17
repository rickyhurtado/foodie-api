class Blog < ApplicationRecord
  default_scope { order('published_at DESC, id DESC') }

  belongs_to :category
  belongs_to :user

  scope :draft, -> { where(status: 'draft') }
  scope :by_user, -> (user_id) { where(user_id: user_id) }

  before_save :sanitize_content
  before_create :set_published_at
  after_create :log_activity_create
  after_update :log_activity_update
  after_destroy :log_activity_delete

  def self.all_published(current_user_id)
    if current_user_id
      where('(published_at <= ? AND status = ?) OR (user_id = ?)', Time.current.to_date, 'published', current_user_id)
    else
      where('published_at <= ? AND status = ?', Time.current.to_date, 'published')
    end
  end

  def self.all_published_by_user(user_id, current_user_id)
    if user_id.eql?(current_user_id)
      where(user_id: user_id)
    else
      where('published_at <= ? AND status = ? AND user_id = ?', Time.current.to_date, 'published', user_id)
    end
  end

  def self.all_published_by_category(category, current_user_id)
    Category.find_by(name: category).blogs.all_published(current_user_id)
  end

  def self.get_blog(blog_id, current_user_id)
    blog = where('id = ?', blog_id)

    if blog.first[:user_id].eql?(current_user_id)
      blog
    else
      where('published_at <= ? AND status = ? AND id = ?', Time.current.to_date, 'published', blog_id)
    end
  end

  private

    def sanitize_content
      self.title = ActionController::Base.helpers.sanitize(self.title, tags: %w())
      self.body = ActionController::Base.helpers.sanitize(self.body, tags: %w(p em strong a img))
    end

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
