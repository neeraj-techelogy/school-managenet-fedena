class Supplier < ActiveRecord::Base
  belongs_to :supplier_type

  validates_presence_of :supplier_type, :name, :contact_number, :address
  validates_length_of :name, :maximum => 250
  validates_length_of :contact_number, :maximum => 50
  validates_length_of :address, :maximum => 2000
  validates_length_of :tin_number, :maximum => 250
  validates_length_of :help_desk, :maximum => 100
end
