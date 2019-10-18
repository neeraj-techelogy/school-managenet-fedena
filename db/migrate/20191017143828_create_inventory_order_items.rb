class CreateInventoryOrderItems < ActiveRecord::Migration
  def self.up
    create_table :inventory_order_items do |t|
      t.references :inventory_order
      t.references :item
      t.integer :quantity
      t.decimal :rate, :default => 0
      t.decimal :tax_percent, :default => 0
      t.decimal :discount_percent, :default => 0
      t.decimal :discount_amount, :default => 0
      t.decimal :additional_charges, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_order_items
  end
end
