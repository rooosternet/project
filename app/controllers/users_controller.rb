class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  # layout 'admin'

  def index
    @users = User.all
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
