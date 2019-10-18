class  PurchaseOrder < InventoryOrder
  belongs_to :supplier
  STATUS_OPTIONS = ['new', 'recieved']
  validates_presence_of :user, :store, :status, :supplier, :date
  validates_inclusion_of :status, :in => STATUS_OPTIONS
  validates_associated :inventory_order_items
  validates_length_of :reference, :maximum => 100
  validates_length_of :invoice_number, :maximum => 100
  validates_numericality_of :other_charges, :less_than_or_equal_to => 1000000, :greater_than_or_equal_to => 0

  def total_amount
    total = 0
    self.inventory_order_items.each do |inventory_order_item|
      total += inventory_order_item.total
    end
    total += other_charges
    total
  end

  def execute user
    ActiveRecord::Base.transaction do
      self.inventory_order_items.each do |inventory_order_item|
        inventory_transaction = self.inventory_transactions.build(
          :user => user,
          :store => self.store,
          :item => inventory_order_item.item,
          :quantity => inventory_order_item.quantity
        )
        inventory_transaction.save
      end

      self.status = 'recieved'
      self.save
    end
  end
end
