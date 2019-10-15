class Store < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :maximum => 250
  validates_length_of :description, :maximum => 1000
end
