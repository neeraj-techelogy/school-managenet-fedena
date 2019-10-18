class Item < ActiveRecord::Base
  belongs_to :item_category
  has_many :inventory_transactions

  validates_presence_of :item_category, :name, :code
  validates_length_of :name, :maximum => 250
  validates_length_of :code, :maximum => 50
  validates_length_of :specification, :maximum => 250
  validates_length_of :description, :maximum => 1000

  def available_quantity
    self.inventory_transactions.sum(:quantity)
  end
end
