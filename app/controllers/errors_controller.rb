class ErrorsController < ApplicationController
	
	layout 'application'
	
	def show
		status_code = params[:code] || 500
		flash.alert = "Status #{status_code}"
		@user=current_user || User.new
		render status_code.to_s, status: status_code
	end
end
