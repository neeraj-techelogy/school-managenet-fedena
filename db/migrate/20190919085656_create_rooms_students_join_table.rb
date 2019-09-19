class CreateRoomsStudentsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :rooms_students, :id => false do |t|
      t.integer :room_id
      t.integer :student_id
    end
  end

  def self.down
    drop_table :rooms_students
  end
end
