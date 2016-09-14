class VisitorsController < ApplicationController
	include ApplicationHelper
	helper :application
	def home
		@confirmation = true if params[:confirmation] == "true"
		unless user_signed_in?
			@user = User.new
			@user.profile = Profile.new
		else
			if current_user.pending?
				sign_out(:user)
				redirect_to root_path
			end
			@user_avatars = session[:user_avatars]
			session[:user_avatars] = false
		end
		@hide_footer = true
		@blog_intro = generate_blog_posts_intro #Rails.env.development? ? [] : generate_blog_posts_intro
	end

end
