class Users::InvitationsController < Devise::InvitationsController

  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?
    yield resource if block_given?
    byebug
    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end
      # respond_with resource, :location => after_invite_path_for(current_inviter)
      render :json => { :responseText => "Invitation sent to #{@user.firstname}." }.to_json , :status => 200
    else
      # respond_with_navigational(resource) { render :new }
      if resource.errors.full_messages.include?("Email has already been taken")
        message = "Invitation sent to #{@user.firstname}."
      end
      render :json => { :responseText => message }.to_json , :status => 500
    end
  end

  # def edit
  #   set_minimum_password_length if respond_to? :set_minimum_password_length
  #   resource.invitation_token = params[:invitation_token]
  #   render :edit
  # end

  protected

  # def resource_from_invitation_token
  #   unless params[:invitation_token] && self.resource = resource_class.find_by_invitation_token(params[:invitation_token], true)
  #     set_flash_message(:alert, :invitation_token_invalid) if is_flashing_format?
  #     redirect_to after_sign_out_path_for(resource_name)
  #   end
  # end

end
