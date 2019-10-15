class SupplierTypesController < ApplicationController
  load_and_authorize_resource
  layout 'scaffold'

  def index
    @supplier_types = SupplierType.all
  end

  def new
    @supplier_type = SupplierType.new
  end

  def edit
  end

  def create
    @supplier_type = SupplierType.new(params[:supplier_type])

    if @supplier_type.save
      flash[:notice] = 'Supplier Type was successfully created.'
      redirect_to(supplier_types_url)
    else
      render :action => "new"
    end
  end

  def update
      if @supplier_type.update_attributes(params[:supplier_type])
        flash[:notice] = 'Supplier Type was successfully updated.'
        redirect_to(supplier_types_url)
      else
        render :action => "edit"
      end
  end

  def destroy
    @supplier_type.destroys
    redirect_to(supplier_types_url)
  end
end
