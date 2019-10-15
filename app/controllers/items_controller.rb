class ItemsController < ApplicationController
  load_and_authorize_resource
  layout 'scaffold'

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(params[:item])

    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to(@item)
    else
      render :action => "new"
    end
  end

  def update
    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item was successfully updated.'
      redirect_to(@item)
    else
      render :action => "edit"
    end
  end

  def destroy
    @item.destroy
    redirect_to(items_url)
  end
end
