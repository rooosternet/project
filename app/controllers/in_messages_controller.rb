class InMessagesController < WebsocketRails::BaseController
  before_action :authenticate_user!

  def index
    @hide_footer = true
    @top_search = true
    @messages = InMessage.allbox.roots.includes(:children).notchat.notarchive.reverse #InMessage.allbox
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

  def bulk_create
    recepients = secure_params[:to_ids].try(:split,',') || secure_params[:to_id]
    recepients.select!{|x| x unless x.blank?}

    if recepients && recepients.is_a?(Array)
      msg_attr = secure_params.dup.except(:to_id,:to_ids)
      msg_attr.merge!(to_id: nil)
      save_messages = []
      fail_messages = []

      recepients.each do |id|
        begin
          msg_attr[:to_id] = id
          message = InMessage.new(msg_attr)
          message.save!
          save_messages << message
        rescue StandardError => e
          msg = message.errors.any? ? message.errors.full_messages.join(',') : "fail to create message!"
          puts "MessagesController::create: #{msg}"
          fail_messages << msg
        end
      end

      if request.xhr?
        if fail_messages.any?
          render :text =>  fail_messages.uniq.join(",") , :status => 503
        else
          puts save_messages.inspect
          render :text => "Message send" , :status => 200
        end
      else
        redirect_to inbox_path, :notice => fail_messages.any? ? fail_messages.uniq.join(",") : "Message send."
      end

    else
      render :text => "Recepient cant be blank!" , :status => 503
    end
  end

  def bulk_create_chat_message
    recepients = secure_params[:to_ids].try(:split,',') || secure_params[:to_id]
    recepients.select!{|x| x unless x.blank?}
    team = Team.find(secure_params[:team_id])
    if recepients && recepients.is_a?(Array)
      msg_attr = secure_params.dup.except(:to_id,:to_ids)
      msg_attr.merge!(to_id: nil)
      save_messages = []
      fail_messages = []

      recepients.each do |id|
        begin
          msg_attr[:to_id] = id.match(/[0-9]+/)[0]
          message = InMessage.new(msg_attr)
          message.save!
          save_messages << @message
        rescue StandardError => e
          msg = message.errors.any? ? message.errors.full_messages.join(',') : "fail to create message!"
          puts "MessagesController::create: #{msg}"
          fail_messages << msg
        end
      end

      if secure_params[:private] == 'false'
        # redirect_to team
      else
        # send_message :create_success, message, :namespace => :chat
        # redirect_to team_path(team, private: true, user_id: secure_params[:to_id])
      end

    else
      render :text => "Recepient cant be blank!" , :status => 503
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
    @message.children.each{|msg| msg.touch if msg.active?}
    render :nothing => true
  end

  def archive

    message = InMessage.find(params[:in_message][:id])
    if message.archive!
      if request.xhr?
        render :text => message.id , :status => 200
      else
        redirect_to inbox_path, :notice => "Message archived."
      end
    else
      if request.xhr?
        render :text => "Fail to archive message." , :status => 500
      else
        redirect_to inbox_path, :alert => "Unable to archived message."
      end
    end


  end

  def destroy
    msg = InMessage.find(params[:id])
    msg.destroy
    if request.xhr?
      render :text => params[:id] , :status => 200
    else
      redirect_to inbox_path, :notice => "Message deleted."
    end
  end

  private

  def secure_params
    params.require(:in_message).permit(:id,:from_id ,:subject,:note,:token,:notify,:private,:parent_id,:team_id, :to_id,:to_ids , :to_id => [])
  end
end
