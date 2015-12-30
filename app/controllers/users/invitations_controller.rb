class Users::InvitationsController < Devise::InvitationsController
   def create
    begin
    @user = User.invite!({email: params[:user][:email]}, current_user) do |u|
      u.skip_invitation = true
      u.firstname = params[:user][:firstname]
      u.lastname = params[:user][:lastname]
      u.freelancer = Freelancer.new
      u.save!
    end

    @user.send_invite_mail(current_user)
    # email = Mailer.invite_email(current_user,@user).deliver_now
    render :json => { :responseText => "Invitation sent to #{@user.name}.." }.to_json , :status => 200
    rescue Exception => e
      render :json => { :responseText => "Fail to sent invitation: #{e.message}" }.to_json , :status => 500
    end
  end
end
