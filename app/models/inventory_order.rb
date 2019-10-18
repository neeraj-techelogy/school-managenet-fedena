class InventoryOrder < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  has_many :inventory_order_items
  has_many :inventory_transactions

  validates_presence_of :inventory_order_items
  after_update :save_inventory_order_items

  def name
    "#{self.type}-#{self.id}"
  end

  def new_inventory_order_item_attributes=(inventory_order_item_attributes)
    inventory_order_item_attributes.each do|attributes|
      inventory_order_items.build(attributes)
    end
  end

  def existing_inventory_order_item_attributes=(inventory_order_item_attributes)
    inventory_order_items.reject(&:new_record?).each do|inventory_order_item|
      attributes = inventory_order_item_attributes[inventory_order_item.id.to_s]
      if attributes
        inventory_order_item.attributes = attributes
      else
        inventory_order_items.delete(inventory_order_item)
      end
    end
  end

  def save_inventory_order_items
    inventory_order_items.each do |inventory_order_item|
      inventory_order_item.save(false)
    end
  end

end
