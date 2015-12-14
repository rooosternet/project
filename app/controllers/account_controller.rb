class AccountController < ApplicationController

	def register
		if request.get?
	      redirect_to root_path
	    else	
			status = 200
			message = "User registered successfully"	
			user = User.find_by_email(user_params[:email])
			if user
				# session[:user_id] = user.id
				# redirect_to root_url, notice: "please Logged in!"
				status = 500
				message = "User already registered"	
			else
				# flash.now.alert = "Invalid email or password"
				# render "new"
				user = User.new(user_params)
				unless user.save
					status = 500
					message = user.errors.any? ? user.errors.full_messages : "fail to create user!"
				# else
					# Mailer.welcome_email(user).deliver_later #deliver_now
				end	
				
			end
			
			render :text => message , :status => status
		end
	end	

	private

	def user_params
		params.require(:user).permit(:name,:email,:email2,:firstname,:lastname, studio_attributes: [:id, :job_title ,:company_name ,:company_website] ,  freelancer_attributes: [:id,:online_portfolio,:linkedin_profile,:company_name,:contact_name,:contact_email,:behance,:vimeo,:skills,:location] )
	end
end
