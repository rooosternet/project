class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  prepend_before_action { request.env["devise.skip_timeout"] = true }
  
  def linkedin
    auth_hash = request.env['omniauth.auth']
    ProfileConnect.create_with_auth_hash(auth_hash)
    redirect_to root_path(profile: true)
  end
  
  def twitter
    auth_hash = request.env['omniauth.auth']
    ProfileConnect.create_with_auth_hash(auth_hash)
    redirect_to root_path(profile: true)
  end

  def vimeo
    auth_hash = request.env['omniauth.auth']
    ProfileConnect.create_with_auth_hash(auth_hash)
    redirect_to root_path(profile: true)
  end
  
  def behance
    auth_hash = request.env['omniauth.auth']
    ProfileConnect.create_with_auth_hash(auth_hash)
    redirect_to root_path(profile: true)
  end

  def dribbble
    auth_hash = request.env['omniauth.auth']
    ProfileConnect.create_with_auth_hash(auth_hash)
    redirect_to root_path(profile: true)
  end

  def passthru
    render status: 404, text: "Not found. Authentication passthru."
  end

  def failure
    set_flash_message :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  protected

  def failed_strategy
    request.respond_to?(:get_header) ? request.get_header("omniauth.error.strategy") : env["omniauth.error.strategy"]
  end

  def failure_message
    exception = request.respond_to?(:get_header) ? request.get_header("omniauth.error") : env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= (request.respond_to?(:get_header) ? request.get_header("omniauth.error.type") : env["omniauth.error.type"]).to_s
    error.to_s.humanize if error
  end

  def after_omniauth_failure_path_for(scope)
    new_session_path(scope)
  end

  def translation_scope
    'devise.omniauth_callbacks'
  end
end
