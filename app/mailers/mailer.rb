class Mailer < ApplicationMailer
	default from: "info@roooster.net"

	def welcome_email(user)
		@user = user
		mail(to: @user.email,subject: "Welcome to Roooster!")
	end

	def invite_email(inviter,invitee)
		mail(to: invitee[:email] ,subject: "#{inviter.name} has invite you to roooster!")
	end
end
