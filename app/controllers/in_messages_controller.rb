class InMessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @hide_footer = true
    @top_search = true
    @messages = InMessage.allbox.roots.includes(:children) #InMessage.allbox
  end
  
  def new
  	
  end

  def create
    @message = InMessage.new(secure_params)
    @message.save
    unless @message.persisted?
      msg = @message.errors.any? ? @message.errors.full_messages.join('<br>') : "fail to create message!"          
      puts "MessagesController::create: #{msg}"
      status = 503
      render :text => "#{@message.to_id}_message", :status => status
    else
      if request.xhr?
        render partial: "message", locals: { message: @message }
      else
        redirect_to inbox_path, :notice => "Message added."
      end
    end
  end

  def edit
    @message = InMessage.find(params[:id])
  end

  def show
    @message = InMessage.find(params[:id])
  end

  def update
    @message = InMessage.find(params[:id])
    if @message.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update Message."
    end
  end

  def touch
    @message = InMessage.find(params[:id])
    @message.touch
    render :nothing => true
  end

  def destroy
    msg = InMessage.find(params[:id])
    msg.destroy
    if request.xhr?
      render :text => params[:id] , :status => 200
    else
      redirect_to users_path, :notice => "Message deleted."
    end
  end

  private

  def secure_params
    params.require(:in_message).permit(:id,:from_id,:to_id,:subject,:note,:token,:notify,:private,:parent_id)
  end
end
