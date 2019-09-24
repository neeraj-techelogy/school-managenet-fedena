class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.references :payer, :polymorphic => true
      t.references :payable, :polymorphic => true
      t.string :title
      t.text :description
      t.integer :amount
      t.date :start_date
      t.date :due_date
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
