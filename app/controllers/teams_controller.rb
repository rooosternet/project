class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update ,:destroy,:update_team_avatar]
  before_action :find_team, only: [:archive]
  before_action :set_menu #, only: [:show, :edit, :update, :destroy]
  before_action :verify_permissions , only: [:show, :edit, :update, :destroy ,:archive]
  after_action :verify_authorized , only: [:index , :show, :edit, :update, :destroy ,:archive]
  protect_from_forgery :except => [:update_team_avatar]

  def update_team_avatar

    begin
    params[:team][:attachments].each do |attachment|
      @post_attachment = @team.attachments.create!(:team_id => @team.id , :attachment => attachment,:attachment_type => 'avatar')
    end
    session[:team_avatar] = !params[:team][:attachments].blank?
    rescue
    end
    redirect_to @team
  end

  def update_teams_order
    unless (team_ids = params[:team_ids]).blank?
      current_user.pref[:teams_order] = team_ids.map { |e| e.to_i }
      current_user.pref.save!
    end
    render :nothing => true
  end

  def index
    authorize current_user
    @teams = current_user.admin? ? Team.all : Team.my
  end

  def new
    @team = Team.new
  end

  # def create
  #   @team = Team.new(team_params)
  #   @team.save
  #   unless @team.persisted?
  #     msg = @team.errors.any? ? @team.errors.full_teams.join('<br>') : "fail to create team!"
  #     puts "TeamsController::create: #{msg}"
  #     status = 503
  #     render :text => msg , :status => status
  #   else
  #     # if request.xhr?
  #       render partial: "team", locals: { team: @team }
  #     # else
  #       # redirect_to inbox_path, :notice => "team added."
  #     # end
  #   end
  # end

  def create
    @team = Team.new(team_params.merge!({owner_id: User.current.id}).except("team_profiles_attributes"))
    respond_to do |format|
      team_profile = params[:team][:team_profiles_attributes].except("team_id").to_hash if params[:team][:team_profiles_attributes]
      @team.team_profiles.build(team_profile) if team_profile
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.js   {
          # render :nothing => true
          render json: @team.id.to_json , status: 200
          # render :show, status: :created, locals: { team: @team }
        }
        format.json { render :show, status: :created, locals: { team: @team } }
      else
        format.html { render :new }
        format.js { render json: @team.errors.full_messages.join(',') , status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
    @team_avatar = session[:team_avatar]
    session[:team_avatar] = false
    @profiles = @team.profiles
    @chat = (@team.name == 'My Contacts')? false : true
    @accepting_profiles = @team.team_profiles.where(invitation_status: ['accepted', nil]).order(is_admin: :desc)
    # @messages = InMessage.allbox.roots.includes(:children).notarchive.reverse #InMessage.allbox
    @profiles_count = @profiles.any? ? @profiles.count : 'No'
    @is_current_user_admin = ((@team.owner_id == current_user.id) or
                              @team.team_profiles
                              .where(profile_id: current_user.profile.id)
                              .first
                              .is_admin) ? true : false
    if params.has_key?(:private)
      @private = true
      @to_id = params[:user_id]
      @messages = InMessage.where(team_id: @team.id, private: true, to_id: [@to_id, current_user.id]).notchatarchive
    else
      @private = false
      @messages = InMessage.where(team_id: @team.id, private: false).notchatarchive
    end

    render (@team.backet)?  'my_contacts' : 'show'
  end

  def update
    hash = Digest::MD5.hexdigest(@team.name)[0...16]
    respond_to do |format|
      if @team.update(team_params.except("team_profiles_attributes"))
        parameters = params[:team][:team_profiles_attributes]
        owner_team = Team.find(parameters['team_id'])
        team_profile = parameters.except("team_id").to_hash if parameters
        if team_profile
          team_profile["invitation_status"] = 'pending'
          @team.team_profiles.build(team_profile)
          user = User.find(team_profile['profile_id'])
          user.profile.update(invitation_hash: hash)
          Mailer.add_to_group_mail(hash, user, owner_team, team_profile).deliver_now
          begin
            @team.save
          rescue ActiveRecord::RecordInvalid => invalid
            puts invalid.message
          end
        end
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.js   { render :nothing => true }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.js { render json: @team.errors, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_profile
    profile_ids = params[:team_profile][:profile_id].blank? ? [] : params[:team_profile][:profile_id].split(',')
    TeamProfile.where(team_id: params[:team_profile][:team_id],profile_id: profile_ids).map(&:destroy)

    redirect_to team_path(params[:team_profile][:team_id])
  end

  def archive
    @team.archive = true
    if @team.save
      if request.xhr?
        render :text => @team.id , :status => 200
      else
        redirect_to root_path, notice: 'Team was successfully archived.'
      end
    else
      if request.xhr?
        render :text => "Fail to archive team." , :status => 500
      else
        redirect_to @team , :alert => "Unable to archived team."
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Team was successfully destroyed.' }
      format.js { render :text => params[:id] , :status => 200 }
      format.json { head :no_content }
    end
    redirect_to root_path
  end

  private

    def verify_permissions
      authorize @team
    end

    def find_team
      @team = Team.where(id: params[:team][:id]).first
    end

    def set_menu
      @hide_footer = true
      @top_search = true
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.where(id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:id,:owner_id,:name,:image,:description,:public,:archive,:team_profiles_attributes => [:team_id,:profile_id])
    end
  end
