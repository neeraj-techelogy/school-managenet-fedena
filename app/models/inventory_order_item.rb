class InventoryOrderItem < ActiveRecord::Base
  belongs_to :inventory_order
  belongs_to :item

  validates_presence_of :item, :quantity
  validates_numericality_of :quantity, :only_integer => true, :less_than_or_equal_to => 100000, :greater_than => 0
  validates_numericality_of :rate, :less_than_or_equal_to => 1000000, :greater_than_or_euqal_to => 0
  validates_numericality_of :tax_percent, :less_than_or_equal_to => 100, :greater_than_or_euqal_to => 0
  validates_numericality_of :discount_percent, :less_than_or_equal_to => 100, :greater_than_or_euqal_to => 0
  validates_numericality_of :discount_amount, :less_than_or_equal_to => 1000000, :greater_than_or_euqal_to => 0
  validates_numericality_of :additional_charges, :less_than_or_equal_to => 1000000, :greater_than_or_euqal_to => 0

  def is_available?
    self.item.available_quantity >= self.quantity
  end

  def total
    price = quantity * rate
    discount = discount_amount
    discount += (discount_percent.to_f/100) * price if discount_percent > 0
    price_after_discount = price - discount
    price_before_tax = price_after_discount + additional_charges
    tax = (tax_percent.to_f / 100) * price_before_tax
    total = price_before_tax + tax
  end
end
