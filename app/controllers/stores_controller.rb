class StoresController < ApplicationController
  load_and_authorize_resource
  layout 'scaffold'

  def index
    @stores = Store.all
  end

  def show
  end

  def new
    @store = Store.new
  end

  def edit
  end

  def create
    @store = Store.new(params[:store])

      if @store.save
        flash[:notice] = 'Store was successfully created.'
        redirect_to(@store)
      else
        render :action => "new"
      end
  end

  def update
    if @store.update_attributes(params[:store])
      flash[:notice] = 'Store was successfully updated.'
      redirect_to(@store)
    else
      render :action => "edit"
    end
  end

  def destroy
    @store.destroy
    redirect_to(stores_url)
  end
end
