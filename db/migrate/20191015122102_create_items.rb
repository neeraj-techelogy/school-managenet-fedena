class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :item_category
      t.string :name
      t.string :code
      t.string :specification
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
