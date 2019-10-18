class IndentsController < ApplicationController
  load_and_authorize_resource
  layout 'scaffold'

  def index
    @indents = Indent.paginate(:page => params[:page])
  end

  def show
  end

  def new
    @indent = Indent.new
    @indent.inventory_order_items.build
  end

  def edit
  end

  def create
    @indent = Indent.new(params[:indent])
    @indent.store = Store.first
    @indent.status = 'new'
    @indent.user = current_user

    if @indent.save
      flash[:notice] = 'Indent was successfully created.'
      redirect_to(@indent)
    else
      render :action => "new"
    end
  end

  def update
    params[:indent][:existing_inventory_order_item_attributes] ||= {}

    if @indent.update_attributes(params[:indent])
      flash[:notice] = 'Indent was successfully updated.'
      redirect_to(@indent)
    else
      render :action => "edit"
    end
  end

  def destroy
    @indent.destroy
    redirect_to(indents_url)
  end

  def update_status
    if params[:status] == 'recieved'
      if @indent.all_items_available?
        @indent.execute current_user
      else
        flash[:notice] = 'All items are not available'
        redirect_to @indent
      end
    else
      @indent.status = params[:status]
      @indent.save
    end

    redirect_to @indent
  end
end
