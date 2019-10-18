class InventoryOrderItemsController < ApplicationController
  # GET /inventory_order_items
  # GET /inventory_order_items.xml
  def index
    @inventory_order_items = InventoryOrderItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inventory_order_items }
    end
  end

  # GET /inventory_order_items/1
  # GET /inventory_order_items/1.xml
  def show
    @inventory_order_item = InventoryOrderItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inventory_order_item }
    end
  end

  # GET /inventory_order_items/new
  # GET /inventory_order_items/new.xml
  def new
    @inventory_order_item = InventoryOrderItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inventory_order_item }
    end
  end

  # GET /inventory_order_items/1/edit
  def edit
    @inventory_order_item = InventoryOrderItem.find(params[:id])
  end

  # POST /inventory_order_items
  # POST /inventory_order_items.xml
  def create
    @inventory_order_item = InventoryOrderItem.new(params[:inventory_order_item])

    respond_to do |format|
      if @inventory_order_item.save
        flash[:notice] = 'InventoryOrderItem was successfully created.'
        format.html { redirect_to(@inventory_order_item) }
        format.xml  { render :xml => @inventory_order_item, :status => :created, :location => @inventory_order_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inventory_order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_order_items/1
  # PUT /inventory_order_items/1.xml
  def update
    @inventory_order_item = InventoryOrderItem.find(params[:id])

    respond_to do |format|
      if @inventory_order_item.update_attributes(params[:inventory_order_item])
        flash[:notice] = 'InventoryOrderItem was successfully updated.'
        format.html { redirect_to(@inventory_order_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inventory_order_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_order_items/1
  # DELETE /inventory_order_items/1.xml
  def destroy
    @inventory_order_item = InventoryOrderItem.find(params[:id])
    @inventory_order_item.destroy

    respond_to do |format|
      format.html { redirect_to(inventory_order_items_url) }
      format.xml  { head :ok }
    end
  end
end
