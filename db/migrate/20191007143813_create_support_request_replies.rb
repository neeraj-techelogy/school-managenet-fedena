class CreateSupportRequestReplies < ActiveRecord::Migration
  def self.up
    create_table :support_request_replies do |t|
      t.references :support_request
      t.references :user
      t.text     :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :support_requests
  end
end
