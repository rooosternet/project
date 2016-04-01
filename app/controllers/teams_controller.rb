class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_menu #, only: [:show, :edit, :update, :destroy]
  

  def index
    @teams = User.current.admin? ? Team.all : Team.my
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
    @team = Team.new(team_params.merge!({owner_id: User.current.id}))
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.js   { 
          render :nothing => true
          # render :show, status: :created, locals: { team: @team } 
        }
        format.json { render :show, status: :created, locals: { team: @team } }
      else
        format.html { render :new }
        format.js { render json: @team.errors, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def show
    @profiles = @team.profiles
    @profiles_count = @profiles.any? ? @profiles.count : 'No'
  end

  def update
    respond_to do |format|
      if @team.update(team_params.except("team_profiles_attributes"))
        team_profile = params[:team][:team_profiles_attributes].except("team_id").to_hash if params[:team][:team_profiles_attributes]
        if team_profile
          @team.team_profiles.build(team_profile) 
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

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.js { render :text => params[:id] , :status => 200 }
      format.json { head :no_content }
    end
  end

  private

  def set_menu
    @hide_footer = true
    @top_search = true
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:id,:owner_id,:name,:image,:description,:public,:team_profiles_attributes => [:team_id,:profile_id])
    end
  end