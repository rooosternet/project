class InMessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @hide_footer = true
    @top_search = true
    @messages = InMessage.inbox
  end
  
  def new
  	
  end

  def create
    message = InMessage.new(secure_params)
    message.save
    unless message.persisted?
      msg = message.errors.any? ? message.errors.full_messages.join('<br>') : "fail to create message!"          
      puts "MessagesController::create: #{msg}"
      status = 503
    end
    render :text => "#{message.to_id}_message", :status => status
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

  def destroy
    user = InMessage.find(params[:id])
    InMessage.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params

    params.require(:in_message).permit(:id,:from_id,:to_id,:note,:token,:notify,:private)
  end
end
