class SuppliersController < ApplicationController
  load_and_authorize_resource
  layout 'scaffold'

  def index
    @suppliers = Supplier.all
  end

  def show
  end

  def new
    @supplier = Supplier.new
  end

  def edit
  end

  def create
    @supplier = Supplier.new(params[:supplier])

      if @supplier.save
        flash[:notice] = 'Supplier was successfully created.'
        redirect_to(@supplier)
      else
        render :action => "new"
      end
  end

  def update
      if @supplier.update_attributes(params[:supplier])
        flash[:notice] = 'Supplier was successfully updated.'
        redirect_to(@supplier)
      else
        render :action => "edit"
      end
  end

  def destroy
    @supplier.destroy
    redirect_to(suppliers_url)
  end
end
