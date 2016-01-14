class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :check_ajax

  # def check_ajax
  # 	if request.xhr?
  # 		render :layout => false
  # 	end
  # end
  
  before_filter :set_current_user

  def set_current_user
    User.current = current_user
    msg = "  Current user: " + (user_signed_in? ? "#{User.current.email} (id=#{User.current.id})" : "anonymous")
    logger.info(msg) if logger
  end


  # before_filter :permitted_parameter, if: :devise_controller?

  # protected

  # def permitted_parameter
  # 	devise_parameter_sanitizer.for(:invite).concat [:firstname,:lastname,:email]
  # 	devise_parameter_sanitizer.for(:invite) do |u|
  # 		u.permit(:firstname,:lastname,:email)
  # 	end
  # end
end
