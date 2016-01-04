class Users::InvitationsController < Devise::InvitationsController
  
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end
      # respond_with resource, :location => after_invite_path_for(current_inviter)
      render :json => { :responseText => "Invitation sent to #{@user.name}." }.to_json , :status => 200
    else
      # respond_with_navigational(resource) { render :new }
      render :json => { :responseText => "Fail to sent invitation: #{resource.errors.full_messages.join(',')}" }.to_json , :status => 500
    end
  end

  #  def create
  #   begin
  #   @user = User.invite!({email: params[:user][:email]}, current_user) do |u|
  #     u.skip_invitation = true
  #     u.firstname = params[:user][:firstname]
  #     u.lastname = params[:user][:lastname]
  #     u.profile = Profile.new
  #     u.save!
  #   end

  #   @user.send_invite_mail(current_user)
  #   # email = Mailer.invite_email(current_user,@user).deliver_now
  #   render :json => { :responseText => "Invitation sent to #{@user.name}.." }.to_json , :status => 200
  #   rescue Exception => e
  #     render :json => { :responseText => "Fail to sent invitation: #{e.message}" }.to_json , :status => 500
  #   end
  # end
end
