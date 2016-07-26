class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user , :only => [:edit,:show,:update,:destroy,:update_avatars,:update_profile_image]
  # after_action :verify_authorized
  protect_from_forgery :except => [:update_avatars]

  layout 'admin'

  def index
    @users = User.includes(:profile).paginate(page: params[:page], per_page: 25)
    @pagecount =  @users.count / 25
    authorize User
  end

  def edit
    authorize @user
  end

  def show
    authorize @user || current_user
  end

  def update
    authorize @user
    if @user.update_attributes(secure_params)
      # @user.profile.skills = params[:user][:profile_attributes][:skills]
      # @user.save!
      respond_to do |format|
        format.html { redirect_to users_path, :notice => "User updated." }
        format.js   { render :nothing => true }
        format.json { render :show, status: :created, locals: { user: @user } }
      end
    else
      respond_to do |format|
        format.html { redirect_to users_path, :alert => "Unable to update user." }
        format.js { render json: @user.errors, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def accepting_invitation
    @user = current_user
    respond_to do |format|
      if @user.profile.invitation_hash == params[:hash]
        @team = Team.find(params[:team_id])
        TeamProfile.find_by_team_id(params[:team_id]).update(invitation_status: 'accepted')
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
      else
        format.html { redirect_to root_path, notice: 'Something went wrong!' }
      end
    end
  end

  def update_profile_image
    authorize @user
    if @user.update_attributes(secure_params)
      render :nothing => true
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_avatars
    authorize @user
    prm = params[:user][:attachments].blank? ? {} : {profile: true}
    params[:user][:attachments].each do |attachment|
      @post_attachment = @user.attachments.create!(:user_id => @user.id , :attachment => attachment,:attachment_type => 'avatar')
    end
    session[:user_avatars] = !params[:user][:attachments].blank?
    redirect_to root_path(prm)
  end

  # "user"=>[{"firstname"=>"TestBB", "lastname"=>"asxascas", "email"=>"sada@saa.clk"}, {"firstname"=>"homfj", "lastname"=>"assdasdas", "email"=>"4yoss@sss.com"}, {"firstname"=>"", "lastname"=>"", "email"=>""}, {"firstname"=>"", "lastname"=>"", "email"=>""}, {"firstname"=>"", "lastname"=>"", "email"=>""}]}
  def batch_invite
    authorize User.current
    @invited = []
    @not_invited = []
    @empty = true
    params[:user].each do |user|
      if !user[:firstname].blank? || !user[:lastname].blank? || !user[:email].blank?
        begin
          @empty = false
          _user = User.invite!({:email => user[:email] , :firstname =>user[:firstname],:lastname=> user[:lastname]},User.current)

          if _user.errors.any?
            if _user.errors.full_messages.include?("Email has already been taken")
              message = "Great! we have already heard about #{_user.name} from other users."
            else
              message = "Fail to sent invitation: #{_user.errors.full_messages.uniq.join(',')}"
            end
            @not_invited << message
          else
            @invited << "Invitation sent to #{_user.name}"
          end
        rescue Exception => e
          @not_invited << "Fail to sent invitation: #{e.message}"
        end
      end
    end
    # render nothing: true
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def find_user
    @user = User.where(id: params[:id]).first
  end


  def secure_params
    params.require(:user).permit(:role,:id,:edit_profile,:name,:email,:email2,:firstname,:lastname,:image,{avatars: []},:profile_attributes => [:id,:is_company, :is_freelancer,:searchable,:public_email,:location,:job_title,:company_name,:company_website,:online_portfolio,:linkedin_profile,:behance,:vimeo,:social_links,:skills => []])
  end

end
