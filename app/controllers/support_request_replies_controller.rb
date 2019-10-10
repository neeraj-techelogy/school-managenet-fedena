class SupportRequestRepliesController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def edit
  end

  def create
    @support_request_reply = SupportRequestReply.new(params[:support_request_reply])
    @support_request_reply.support_request = SupportRequest.find(params[:support_request_id])
    @support_request_reply.user = current_user

    if @support_request_reply.save
      flash[:notice] = 'Support Request Reply was successfully created.'
      redirect_to(@support_request_reply.support_request)
    else
      render :action => "new"
    end
  end

  def update
    if @support_request_reply.update_attributes(params[:support_request_reply])
      flash[:notice] = 'Support Request Reply was successfully updated.'
      redirect_to(@support_request_reply.support_request)
    else
      render :action => "edit"
    end
  end

  def destroy
    @support_request_reply.destroy
    redirect_to(@support_request_reply.support_request)
  end

end
