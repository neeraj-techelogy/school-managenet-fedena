class Hostel < ActiveRecord::Base
  self.inheritance_column = nil

  has_many :rooms

  validates_presence_of :name, :type
  validates_uniqueness_of :name
  validates_length_of :name, :maximum => 80
end
