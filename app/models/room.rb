class Room < ActiveRecord::Base
  attr_accessor :number_of_rooms
  belongs_to :hostel
  validates_presence_of :hostel_id, :room_number, :students_per_room
  validates_numericality_of :room_number, :only_integer => true, :greater_than => 0
  validates_numericality_of :students_per_room, :only_integer => true, :less_than_or_equal_to => 20, :greater_than => 0
  validates_uniqueness_of :room_number, :scope => :hostel_id
  #validates_numericality_of :number_of_rooms, :only_integer => true, :less_than_or_equal_to => 50, :greater_than => 0, :allow_blank => true

  default_scope :order=>'room_number ASC'
end
