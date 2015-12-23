class VisitorsController < ApplicationController
	
	def home
		unless user_signed_in?
			@user = User.new
			@user.studio = Studio.new
			@user.freelancer = Freelancer.new
		else
			if current_user.pending?
				sign_out(:user)
				redirect_to root_path
			# else	
				# render :template => 'pages/search' , :layouts => true
			end
		end	
	end

	
end