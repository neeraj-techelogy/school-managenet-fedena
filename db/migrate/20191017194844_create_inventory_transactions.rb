class CreateInventoryTransactions < ActiveRecord::Migration
  def self.up
    create_table :inventory_transactions do |t|
      t.references :store
      t.references :user
      t.references :item
      t.references :inventory_order
      t.integer    :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_transactions
  end
end
