class Room < ActiveRecord::Base
  attr_accessor :number_of_rooms

  belongs_to :hostel
  has_and_belongs_to_many :students

  validates_presence_of :hostel_id, :room_number, :students_per_room, :rent
  validates_numericality_of :room_number, :only_integer => true, :greater_than => 0
  validates_numericality_of :students_per_room, :only_integer => true, :less_than_or_equal_to => 20, :greater_than => 0
  validates_numericality_of :rent, :less_than_or_equal_to => 1000000, :greater_than => 0
  validates_uniqueness_of :room_number, :scope => :hostel_id
  #validates_numericality_of :number_of_rooms, :only_integer => true, :less_than_or_equal_to => 50, :greater_than => 0, :allow_blank => true

  default_scope :order=>'room_number ASC'

  def rent_in_bucks
    '%.2f' % (rent.to_f/100) if rent # convert to pennies
  end

  def rent_in_bucks=(bucks)
    self.rent = bucks.to_d*100 if bucks.present?
  end

  def availability
    self.students_per_room - self.students.count
  end
end
