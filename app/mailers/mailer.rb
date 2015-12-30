class Mailer < ApplicationMailer
	default from: "info@roooster.net"

	def welcome_email(user)
		@user = user
		@subject = "Welcome to Roooster!"
		mail(to: @user.email,subject: "Welcome to Roooster!")
	end

	def welcome_email_freelancer(user)
		@user = user
		mail(to: @user.email,subject: "Welcome to Roooster!")
	end

	def invite_email(inviter,invitee,token)
		@inviter = inviter 
		@invitee = invitee
		
		@invitation_link = accept_user_invitation_url(:invitation_token => token)
		mail(to: @invitee.email ,subject: "You have been invited to join Roooster by #{@inviter.name}")
	end


	# def invite_message(user, venue, from, subject, content)
	# 	@user = user
	# 	@token = user.raw_invitation_token
	# 	invitation_link = accept_user_invitation_url(:invitation_token => @token)

	# 	mail(:from => from, :bcc => from, :to => @user.email, :subject => subject) do |format|
	# 		content = content.gsub '{{first_name}}', user.first_name
	# 		content = content.gsub '{{last_name}}', user.last_name
	# 		content = content.gsub '{{full_name}}', user.full_name
	# 		content = content.gsub('{{invitation_link}}', invitation_link)
	# 		format.text do
	# 			render :text => content
	# 		end
	# 	end
	# end

end



