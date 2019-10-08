class SupportRequest < ActiveRecord::Base
  belongs_to :reporter, :class_name => 'User', :foreign_key => 'reporter_id'
  belongs_to :assignee, :class_name => 'User', :foreign_key => 'assignee_id'
  has_many :support_request_replies

  named_scope :not_accepted, { :conditions=> ['status != "accepted"  OR status IS NULL'] }

  validates_presence_of :title, :assignee, :reporter, :status

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
end
