class SupportRequestsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.admin?
      @support_requests = SupportRequest.not_accepted.paginate(:page => params[:page])
    else
      @support_requests = (current_user.assigned_support_requests.not_accepted +  current_user.support_requests.not_accepted).uniq.paginate(:page => params[:page])
    end
  end

  def show
    @support_request_reply = SupportRequestReply.new(:support_request => @support_request)
  end

  def new
    @support_request = SupportRequest.new

    respond_to do |format|
      format.html
    end
  end

  def edit
  end

  def create
    @support_request = SupportRequest.new(params[:support_request])
    @support_request.reporter = current_user
    @support_request.status = 'open'

    respond_to do |format|
      if @support_request.save
        flash[:notice] = 'SupportRequest was successfully created.'
        format.html { redirect_to(@support_request) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @support_request.update_attributes(params[:support_request])
        flash[:notice] = 'SupportRequest was successfully updated.'
        format.html { redirect_to(@support_request) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @support_request.destroy
    redirect_to(support_requests_url)
  end

  def update_status
    if params[:progress] === 'next'
      @support_request.status = @support_request.next_status if @support_request.next_status
      @support_request.save
      flash[:notice] = "Support Request progressed to #{@support_request.status.humanize} status"
    elsif params[:progress] === 'back'
      @support_request.status = @support_request.previous_status if @support_request.previous_status
      @support_request.save
      flash[:notice] = "Support Request reverted to #{@support_request.status.humanize} status"
    else
      flash[:notice] = "Support Request remains in #{@support_request.status.humanize} status"
    end


    redirect_to(@support_request)
  end
end
