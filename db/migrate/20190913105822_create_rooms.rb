class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.references :hostel
      t.integer :room_number
      t.integer :students_per_room

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
