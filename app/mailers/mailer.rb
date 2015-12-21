class Mailer < ApplicationMailer
	default from: "info@roooster.net"

	def welcome_email(user)
		@user = user
		mail(to: @user.email,subject: "Welcome to Roooster!")
	end

	def welcome_email_freelancer(user)
		@user = user
		mail(to: @user.email,subject: "Welcome to Roooster!")
	end

	def invite_email(inviter,invitee)
		@inviter = inviter
		@invitee = invitee
		mail(to: invitee[:email] ,subject: "You have been invited to join Roooster by #{inviter.name}")
	end
end



