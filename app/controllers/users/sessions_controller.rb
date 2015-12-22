class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
before_filter :check_user_role , only: [:create]
skip_before_filter :verify_authenticity_token, :only => [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # def new
  #   self.resource = resource_class.new(sign_in_params)
  #   clean_up_passwords(resource)
  #   yield resource if block_given?
  #   respond_with(resource, serialize_options(resource), :layout => !request.xhr? )
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end


  def check_user_role
    if current_user && current_user.pending?
      sign_out(:user)
      message = "Your account is pending approval!"     
      render :text => message , :status => 500
    end 
    true
  end

end
