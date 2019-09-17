class HostelsController < ApplicationController
  def manage_hostels
    
  end

  # GET /hostels
  # GET /hostels.xml
  def index
    @hostels = Hostel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hostels }
    end
  end

  # GET /hostels/1
  # GET /hostels/1.xml
  def show
    @hostel = Hostel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hostel }
    end
  end

  # GET /hostels/new
  # GET /hostels/new.xml
  def new
    @hostel = Hostel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hostel }
    end
  end

  # GET /hostels/1/edit
  def edit
    @hostel = Hostel.find(params[:id])
  end

  # POST /hostels
  # POST /hostels.xml
  def create
    @hostel = Hostel.new(params[:hostel])

    respond_to do |format|
      if @hostel.save
        flash[:notice] = 'Hostel was successfully created.'
        format.html { redirect_to(@hostel) }
        format.xml  { render :xml => @hostel, :status => :created, :location => @hostel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hostel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hostels/1
  # PUT /hostels/1.xml
  def update
    @hostel = Hostel.find(params[:id])

    respond_to do |format|
      if @hostel.update_attributes(params[:hostel])
        flash[:notice] = 'Hostel was successfully updated.'
        format.html { redirect_to(@hostel) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hostel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hostels/1
  # DELETE /hostels/1.xml
  def destroy
    @hostel = Hostel.find(params[:id])
    @hostel.destroy

    respond_to do |format|
      format.html { redirect_to(hostels_url) }
      format.xml  { head :ok }
    end
  end
end
