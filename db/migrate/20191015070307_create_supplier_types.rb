class CreateSupplierTypes < ActiveRecord::Migration
  def self.up
    create_table :supplier_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_types
  end
end
