class  Indent < InventoryOrder
  STATUS_OPTIONS = ['new', 'recieved', 'rejected']
  validates_presence_of :user, :store, :status
  validates_inclusion_of :status, :in => STATUS_OPTIONS

  def all_items_available?
    self.inventory_order_items.all? { |inventory_order_item| inventory_order_item.is_available? }
  end


  def execute user
    return false unless self.all_items_available?
    ActiveRecord::Base.transaction do
      self.inventory_order_items.each do |inventory_order_item|
        inventory_transaction = self.inventory_transactions.build(
          :user => user,
          :store => self.store,
          :item => inventory_order_item.item,
          :quantity => -inventory_order_item.quantity
        )
        inventory_transaction.save
      end

      self.status = 'recieved'
      self.save
    end
  end

end
