class Users::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
skip_before_filter :verify_authenticity_token
# before_filter :configure_account_update_params, only: [:update]
# before_filter :configure_permitted_parameters

# PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    # resource_updated = resource.update_attributes(account_update_params)
    # resource_updated = update_resource(resource, account_update_params)
    resource_updated = update_resource(resource, user_secure_params)

    yield resource if block_given?

    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
        :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      if request.xhr?
        # render :text => 'User updated' , :status => 200
        render :json => { :responseText => "User updated" }.to_json , :status => 200
      else
        respond_with resource, location: after_update_path_for(resource)
      end
    else
      if request.xhr?

        # render :text => "User update failed #{resource.errors.full_messages.join(',') if resource.errors.any?}" , :status => 500
        render :text => { :responseText => "User update failed #{resource.errors.full_messages.join(',') if resource.errors.any?}" }.to_json , :status => 500
      else
        clean_up_passwords resource
        respond_with resource
      end
    end

  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    begin

      build_resource(sign_up_params)

      if User.find_by_email(resource.email)
        render :text => "User already registered" , :status => 500
      else

        resource.save
        yield resource if block_given?
        if resource.persisted?
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
            # respond_with resource, location: after_sign_up_path_for(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
            expire_data_after_sign_in!
            # respond_with resource, location: after_inactive_sign_up_path_for(resource)
          end
          render :text => "User registered successfully" , :status => 200
        else
          clean_up_passwords resource
          set_minimum_password_length
          # respond_with resource
          message = resource.errors.any? ? resource.errors.full_messages.join('<br>') : "fail to create user!"
          render :text => message , :status => 500
        end
      end
    rescue Exception => e
      message = resource.errors.any? ? resource.errors.full_messages.join('<br>') : "fail to create user!"
      render :text => message , :status => 500
    end
  end

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up).push(:name, :firstname, :lastname,:edit_profile, :email2)
  # end

  def update_resource(resource, _params)
    if params[:chpass].try(:eql?,"true")
      resource.update_with_password(_params)
    else
      resource.update_without_password(_params)
    end
  end

  def after_sign_up_path_for(resource)
    signed_in_root_path(resource)
  end

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  def user_secure_params
    params.require(:user).permit(:role,:id,:password, :current_password,:password_confirmation,:edit_profile,:name,:email,:email2,:firstname,:lastname,:image,:avatars => [],:profile_attributes => [:id,:is_company, :is_freelancer,:searchable,:public_email,:location,:job_title,:company_name,:company_website,:online_portfolio,:linkedin_profile,:behance,:vimeo,:social_links,:skills => []])
  end

  # def create


  #   build_resource(params[:user])

  #   resource.save
  #   yield resource if block_given?
  #   if resource.persisted?
  #     if resource.active_for_authentication?
  #       set_flash_message :notice, :signed_up if is_flashing_format?
  #       sign_up(resource_name, resource)
  #       respond_with resource, location: after_sign_up_path_for(resource)
  #     else
  #       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
  #       expire_data_after_sign_in!
  #       respond_with resource, location: after_inactive_sign_up_path_for(resource)
  #     end
  #   else
  #     clean_up_passwords resource
  #     set_minimum_password_length
  #     respond_with resource
  #   end
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << [:name,:firstname, :lastname ,:edit_profile, :email2 ,:terms_of_service,:subscribe,:image]
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
