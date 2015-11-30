class VisitorsController < ApplicationController
	
	def home
		unless user_signed_in?
			@user = User.new
			@user.studio = Studio.new
			@user.freelancer = Freelancer.new
		else
			@user = current_user	
			render :template => 'pages/search' , :layouts => true
		end	
	end
end