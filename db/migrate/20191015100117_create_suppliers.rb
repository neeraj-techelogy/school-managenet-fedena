class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.references :supplier_type
      t.string :name
      t.string :contact_number
      t.text :address
      t.string :tin_number
      t.string :help_desk

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
