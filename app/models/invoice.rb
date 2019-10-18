class  Invoice < InventoryOrder
  STATUS_OPTIONS = ['new', 'delivered']
  validates_presence_of :user, :store, :status, :user_name, :user_address, :is_paid
  validates_inclusion_of :status, :in => STATUS_OPTIONS
  validates_associated :inventory_order_items
  validates_length_of :user_name, :maximum => 100
  validates_length_of :user_address, :maximum => 500
end
