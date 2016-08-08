class Users::PasswordsController < Devise::PasswordsController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create

    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?
    if successfully_sent?(resource)
      render :json => { :responseText => "Your account password has been reset." }.to_json , :status => 200

    else
      render :text => "Reset passowrd failed!" , :status => 500
    end
  end
  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected
  protected

  def after_resetting_password_path_for(resource)
    byebug
    signed_in_root_path(resource)
  end

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
