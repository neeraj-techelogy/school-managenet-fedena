class CreateSupportRequests < ActiveRecord::Migration
  def self.up
    create_table :support_requests do |t|
      t.references :reporter
      t.references :assignee
      t.string     :title
      t.text       :description
      t.string     :status

      t.timestamps
    end
  end

  def self.down
    drop_table :support_requests
  end
end
