class CreateInventoryOrder < ActiveRecord::Migration
  def self.up
    create_table :inventory_orders do |t|
      # common
      t.references :user
      t.references :store
      t.string     :type
      t.string     :status
      t.boolean    :is_paid, :default => false

      # Purchase orders
      t.references :supplier
      t.date       :date
      t.string     :reference
      t.string     :invoice_number
      t.date       :invoice_date
      t.date       :reciept_date
      t.decimal    :other_charges, :default => 0

      # Invoices
      t.string     :user_name
      t.text       :user_address

      # Indents

      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_orders
  end
end
