class SupportRequest < ActiveRecord::Base
  belongs_to :reporter, :class_name => 'User', :foreign_key => 'reporter_id'
  belongs_to :assignee, :class_name => 'User', :foreign_key => 'assignee_id'
  has_many :support_request_replies

  named_scope :not_accepted, { :conditions=> ['status != "accepted"  OR status IS NULL'] }

  validates_presence_of :title, :assignee, :reporter, :status

  STATUS_OPTIONS = ['open', 'in_progress', 'waiting_response', 'completed', 'accepted']
  validates_inclusion_of :status, {:in => STATUS_OPTIONS}

  def waiting_for
    self.last_replied_by === self.assignee ? self.reporter : self.assignee
  end

  def last_replied_by
    if self.support_request_replies.any?
      self.support_request_replies.last.user
    else
      self.reporter
    end
  end

  def status_index
    STATUS_OPTIONS.find_index(self.status)
  end

  def next_status
    (self.status_index >= (STATUS_OPTIONS.length - 1)) ? nil : STATUS_OPTIONS[self.status_index + 1]
  end

  def previous_status
    (self.status_index <= 0) ? nil : STATUS_OPTIONS[self.status_index - 1]
  end
end
