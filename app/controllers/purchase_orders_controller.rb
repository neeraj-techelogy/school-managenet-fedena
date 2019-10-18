class PurchaseOrdersController < ApplicationController
  load_and_authorize_resource
  layout 'scaffold'

  def index
    @purchase_orders = PurchaseOrder.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @purchase_order = PurchaseOrder.new
    @purchase_order.inventory_order_items.build
  end

  def create
    @purchase_order = PurchaseOrder.new(params[:purchase_order])
    @purchase_order.store = Store.first
    @purchase_order.status = 'new'
    @purchase_order.user = current_user
    @purchase_order.is_paid = 0

    if @purchase_order.save
      flash[:notice] = 'Purchase Order was successfully created.'
      redirect_to(@purchase_order)
    else
      render :action => "new"
    end
  end

  def update
    params[:purchase_order][:existing_inventory_order_item_attributes] ||= {}

    if @purchase_order.update_attributes(params[:purchase_order])
      flash[:notice] = 'Purchase Order was successfully updated.'
      redirect_to(@purchase_order)
    else
      render :action => "edit"
    end
  end

  def destroy
    @purchase_order.destroy
    redirect_to(purchase_orders_url)
  end

  def update_status
    if params[:status] == 'recieved'
      @purchase_order.execute current_user
    else
      @purchase_order.status = params[:status]
      @purchase_order.save
    end

    redirect_to @purchase_order
  end
end
