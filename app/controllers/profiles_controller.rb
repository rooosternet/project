class ProfilesController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized

  # {"search"=>"", "skills"=>"Motion Graphics"}
  def index
    
  	@profiles_count = 'No'
    @profiles = []
    scope = Profile.active
    params[:search].split(' ').collect{ |search_string| scope = scope.live_search(search_string) } if !params[:search].blank?
    scope = scope.skill_search(params[:skills]) if !params[:skills].blank?

    unless scope.blank?
    	@profiles_count = scope.count
    	@profiles = scope
    end

    render :template => 'visitors/home' if params[:skills].blank? && params[:search].blank?
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
