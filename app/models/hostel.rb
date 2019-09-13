class Hostel < ActiveRecord::Base
  self.inheritance_column = nil
  validates_presence_of :name, :type
end
