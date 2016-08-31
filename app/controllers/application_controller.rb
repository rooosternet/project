class ApplicationController < ActionController::Base
  include Pundit
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

  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
      (request.user_agent =~ (Mobile|webOS)) && (request.user_agent !~ /iPad/)
    end
  end

  helper_method :mobile_device?

  def set_current_user
    User.current = current_user
    msg = "  Current user: " + (user_signed_in? ? "#{User.current.email} (id=#{User.current.id})" : "anonymous")
    logger.info(msg) if logger
  end

  private

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
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
