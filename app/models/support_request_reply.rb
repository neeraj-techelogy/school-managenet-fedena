class SupportRequestReply < ActiveRecord::Base
  belongs_to :support_request
  belongs_to :user

  validates_presence_of :support_request, :user, :comment
  validates_length_of :comment, { :maximum => 10000 }
end
