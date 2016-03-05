class ProfilesController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized
  include ApplicationHelper
  helper :application
  
  # {"search"=>"", "skills"=>"Motion Graphics"}
  def index
    @hide_footer = true
    @top_search = true
    
  	@profiles_count = 'No'
    @profiles = []
    scope = Profile.active

    @search_by = params[:search_by].blank? ?  'All' : params[:search_by]

    case @search_by
    when "Location"
      params[:search].split(' ').collect{ |search_string| scope = scope.location_search(search_string) } if !params[:search].blank?
    when "People"
       params[:search].split(' ').collect{ |search_string| scope = scope.people_search(search_string) } if !params[:search].blank?
    when "Skill"  
      params[:search].split(' ').collect{ |search_string| scope = scope.skill_search(search_string) } if !params[:search].blank?
    end
    
    params[:search].split(' ').collect{ |search_string| scope = scope.live_search(search_string) } if !params[:search].blank?
    scope = scope.skill_search(params[:skills]) if !params[:skills].blank?
    scope = scope.location_search(params[:location]) if !params[:location].blank?
    
    @profiles_count = scope.count
    @profiles = scope.order("users.firstname,users.lastname asc").paginate(page: params[:page], per_page: 10)
    render :template => 'visitors/home' if params[:location].blank? && params[:skills].blank? && params[:search].blank?
  end

  def edit
    
  end

  # def invite
  #   # "field-suggest-first-name"=>"yossi",
  #   # "field-suggest-last-name"=>"edri",
  #   # "field-suggest-email"=>"yossiedri@gmail.com",
  #   # "field-suggest-website"=>"",
  #   # "field-suggest-location"=>"",
  #   # "field-suggest-linkedin"=>"",
  #   # "field-suggest-behance"=>"",
  #   # "field-suggest-vimeo"=>""
  #   begin
  #     freelancer = {
  #                 name: params["field-suggest-first-name"] + " " + params["field-suggest-last-name"],
  #                 firstname: params["field-suggest-first-name"],
  #                 lastname: params["field-suggest-last-name"],
  #                 email: params["field-suggest-email"]
  #                }
  #     raise "Name cannot be empty!" if freelancer[:name].blank?
  #     raise "Email cannot be empty!" if freelancer[:email].blank?           

  #     Mailer.invite_email(current_user,freelancer).deliver_now
  #     render :json => { :responseText => "Invitation sent to #{freelancer[:name]}.." }.to_json , :status => 200
  #   rescue Exception => e
  #     render :json => { :responseText => "Fail to sent invitation: #{e.message}" }.to_json , :status => 500
  #   end
  
  # end

end
