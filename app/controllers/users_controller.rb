class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  layout 'admin'

  def index
    @users = User.includes(:profile).paginate(page: params[:page], per_page: 25)
    @pagecount =  @users.count / 25
    authorize User
  end
  
  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      # @user.profile.skills = params[:user][:profile_attributes][:skills]
      # @user.save!
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  # "user"=>[{"firstname"=>"TestBB", "lastname"=>"asxascas", "email"=>"sada@saa.clk"}, {"firstname"=>"homfj", "lastname"=>"assdasdas", "email"=>"4yoss@sss.com"}, {"firstname"=>"", "lastname"=>"", "email"=>""}, {"firstname"=>"", "lastname"=>"", "email"=>""}, {"firstname"=>"", "lastname"=>"", "email"=>""}]}
  def batch_invite
    authorize User.current
    invited = []
    not_invited = []
    params[:user].each do |user|
      if user[:firstname] && user[:lastname] && user[:email]
        begin
          _user = User.invite!({:email => user[:email] , :firstname =>user[:firstname],:lastname=> user[:lastname]},User.current)  
          invited << _user.id
        rescue Exception => e
          not_invited << [error: e.message,user: user]
        end
      else
          not_invited << [error: e.message,user: user]
      end  
    end
    render nothing: true
    
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role,:id,:edit_profile,:name,:email,:email2,:firstname,:lastname,:profile_attributes => [:id,:is_company, :is_freelancer,:searchable,:public_email,:location,:job_title,:company_name,:company_website,:online_portfolio,:linkedin_profile,:behance,:vimeo,:social_links,:skills => []])
  end

end
