class InventoryTransaction < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  belongs_to :store
  belongs_to :inventory_order

  validates_presence_of :item, :user, :store, :inventory_order, :quantity
  validates_numericality_of :quantity, :only_integer => true
end
