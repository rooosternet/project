class VisitorsController < ApplicationController
	include ApplicationHelper
	helper :application
	def home
		unless user_signed_in?
			@user = User.new
			@user.profile = Profile.new
		else
			if current_user.pending?
				sign_out(:user)
				redirect_to root_path
			end
		end	

		@blog_intro = generate_blog_posts_intro
	end

end