class SupplierType < ActiveRecord::Base
  has_many :suppliers, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :maximum => 250
end
