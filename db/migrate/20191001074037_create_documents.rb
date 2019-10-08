class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.references :attachable, :polymorphic => true
      t.string     :name
      t.string     :attachment_file_name
      t.string     :attachment_content_type
      t.binary     :attachment_data, :limit => 1.megabyte
      t.integer    :attachment_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
