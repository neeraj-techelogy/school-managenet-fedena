class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :invoice_id
      t.string :payment_mode
      t.reference_number :string
      t.integer :integer
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
