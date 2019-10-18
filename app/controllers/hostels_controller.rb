class HostelsController < ApplicationController
  load_and_authorize_resource

  def manage_hostels
  end

  def index
    @hostels = Hostel.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @hostel = Hostel.new
  end

  def edit
  end

  def create
    @hostel = Hostel.new(params[:hostel])

    if @hostel.save
      flash[:notice] = 'Hostel was successfully created.'
      redirect_to(@hostel)
    else
      render :action => "new"
    end
  end

  def update
    if @hostel.update_attributes(params[:hostel])
      flash[:notice] = 'Hostel was successfully updated.'
      redirect_to(@hostel)
    else
      render :action => "edit"
    end
  end

  def destroy
    @hostel.destroy
    redirect_to(hostels_url)
  end
end
