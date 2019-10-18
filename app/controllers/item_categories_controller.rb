class ItemCategoriesController < ApplicationController
  load_and_authorize_resource
  layout 'scaffold'

  def index
    @item_categories = ItemCategory.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @item_category = ItemCategory.new
  end

  def edit
  end

  def create
    @item_category = ItemCategory.new(params[:item_category])

    if @item_category.save
      redirect_to(@item_category)
    else
      render :action => "new"
    end
  end

  def update
    if @item_category.update_attributes(params[:item_category])
      flash[:notice] = 'ItemCategory was successfully updated.'
      redirect_to(@item_category)
    else
      render :action => "edit"
    end
  end

  def destroy
    @item_category.destroy
    redirect_to(item_categories_url)
  end
end
