class Mailer < Devise::Mailer
	default from: "info@roooster.net"

	helper :application # gives access to all helpers defined within `application_helper`.
  	include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  	default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

	
	# def confirmation_instructions(record, token, opts={})
 #      @token = token
 #      devise_mail(record, :confirmation_instructions, opts)
 #    end

    def reset_password_instructions(record, token, opts={})
      @token = token
      @subject = "Your Roooster password reset instructions"
      opts.merge!(subject: @subject)
      devise_mail(record, :reset_password_instructions, opts)
    end

    def unlock_instructions(record, token, opts={})
      @token = token
      devise_mail(record, :unlock_instructions, opts)
    end

    def password_change(record, opts={})
      devise_mail(record, :password_change, opts)
    end	

	def confirmation_instructions(record, token, opts={})
		@user = record
		@token = token
		@subject = "Welcome to Roooster!"
		opts.merge!(subject: @subject)
      	devise_mail(record, :confirmation_instructions, opts)
	end
	# alias_method :confirmation_instructions, :welcome_email

	def invitation_instructions(record, token, opts={})
      @token = token
      @user = record
      @inviter = record.invited_by
      @subject = "You have been invited to join Roooster by #{@inviter.name}"
      if (_to = record.email).blank?
       _to= record.unconfirmed_email 
   	  end
      opts.merge!(to: _to, subject: @subject)
      devise_mail(record, :invitation_instructions, opts)
    end


    def in_mail(from,to,token,note)
      @token_url = message_show_url(token: token)
      @message = note
      @from = from
      @to = to
      @subject = "#{@from.name} sent you a message via Roooster."
      mail(to: to.email ,from: from.email, subject: @subject)
      # mail(to: "4yossiedri@gmail.com" ,from: "4yossiedri@gmail.com", subject: @subject)
    end

	def notification_mail(user,subject = "New user registered!")
		@user = user
		mail(to: "info@roooster.net",subject: subject)
	end

	def directory_activation(user)
		@user = user
		mail(to: @user.email , subject: "Congratulations, you now appear on the Roooster listings board")
	end
		 
	 # message = {"name"=>"yossi", "email"=>"yedri@mellanox.com", "subject"=>"subject", "note"=>"message"}
	def contact_us(message)
      @message = message["note"]
      @from = message["email"]
      @to = "info@roooster.net"
      @subject = message["subject"]
      @name =  message["name"]
      mail(to: @to ,from: @from, subject: @subject)
    end


	# def invite_email(inviter,invitee,token)
	# 	@inviter = inviter 
	# 	@invitee = invitee
		
	# 	@invitation_link = accept_user_invitation_url(:invitation_token => token)
	# 	mail(to: @invitee.email ,subject: "You have been invited to join Roooster by #{@inviter.name}")
	# end


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



