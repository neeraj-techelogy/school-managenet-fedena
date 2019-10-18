class RoomsController < ApplicationController
  load_and_authorize_resource

  def index
    @hostels = Hostel.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(params[:room])

    if @room.save
      number_of_rooms = params[:room][:number_of_rooms].to_i
      if number_of_rooms > 0
        i = @room.room_number + 1

        while i < @room.room_number + number_of_rooms
          room = Room.new(:hostel_id => @room.hostel.id, :students_per_room => @room.students_per_room, :room_number => i, :rent_in_bucks => @room.rent_in_bucks)
          room.save
        	i = i + 1
        end
        flash[:notice] = number_of_rooms + ' rooms successfully created.'
      else
        flash[:notice] = 'Room was successfully created.'
      end

      redirect_to(@room)
    else
      render :action => "new"
    end
  end

  def update
    if @room.update_attributes(params[:room])
      flash[:notice] = 'Room was successfully updated.'
      redirect_to(@room)
    else
      render :action => "edit"
    end
  end

  def destroy
    @room.destroy
    redirect_to(rooms_url)
  end

  def allocation
  end

  def allocation_student
    @student = Student.find(params[:id])
    @hostels = Hostel.all
  end

  def show_rooms_list
    unless params[:id].nil?
      @hostel = Hostel.find(params[:id])
      @student = Student.find(params[:student_id])
      render :update do |page|
        page.replace_html 'rooms', :partial => 'rooms_list'
      end
    end
  end

  def allocate
    @room = Room.find(params[:room_id])
    @student = Student.find(params[:student_id])

    if @student.rooms.count > 0
      flash[:notice] = "A room is already allocated to #{@student.full_name}"
      render :js => "window.location = '#{room_path(@student.rooms.first)}'"
    elsif @room.availability <= 0
      flash[:notice] = "Room not available"
      render :js => "window.location = '/rooms/allocation_student/#{@student.id}'"
    else
      @room.students << @student
      @room.save
      flash[:notice] = "Room allocated to #{@student.full_name}"
      render :js => "window.location = '/rooms/allocation'"
    end
  end

  def vacate
    @room = Room.find(params[:room_id])
    @student = Student.find(params[:student_id])
    if @room.students.include?(@student)
      @room.students.delete(@student)
      flash[:notice] = "Room vacated"
    else
      flash[:notice] = "This room is not allocated to #{@student.full_name}"
    end

    render :js => "window.location = '/rooms/allocation'"
  end
end
