class SupportRequestReply < ActiveRecord::Base
  belongs_to :support_request
  belongs_to :user
end
