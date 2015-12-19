class FreelancersController < ApplicationController
  before_action :authenticate_user!
  # after_action :verify_authorized

  # {"search"=>"", "skiles"=>"Motion Graphics"}
  def index
  	@freelancers_count = 'No'
    @freelancers = []
    scope = Freelancer.active
    params[:search].split(' ').collect{ |search_string| scope = scope.live_search(search_string) } if !params[:search].blank?
    scope.skill_search(params[:skiles]) if !params[:skiles].blank?

    unless scope.blank?
    	@freelancers_count = scope.count
    	@freelancers = scope
    end

    render :template => 'pages/search' if params[:skiles].blank? && params[:search].blank?
  end

  def invite
    # "field-suggest-first-name"=>"yossi",
    # "field-suggest-last-name"=>"edri",
    # "field-suggest-email"=>"yossiedri@gmail.com",
    # "field-suggest-website"=>"",
    # "field-suggest-location"=>"",
    # "field-suggest-linkedin"=>"",
    # "field-suggest-behance"=>"",
    # "field-suggest-vimeo"=>""
    begin
      freelancer = {
                  name: params["field-suggest-first-name"] + " " + params["field-suggest-last-name"],
                  firstname: params["field-suggest-first-name"],
                  lastname: params["field-suggest-last-name"],
                  email: params["field-suggest-email"]
                 }
      raise "Name cannot be empty!" if freelancer[:name].blank?
      raise "Email cannot be empty!" if freelancer[:email].blank?           

      Mailer.invite_email(current_user,freelancer).deliver_now
      render :json => { :responseText => "Invitation sent to #{freelancer[:name]}.." }.to_json , :status => 200
    rescue Exception => e
      render :json => { :responseText => "Fail to sent invitation: #{e.message}" }.to_json , :status => 500
    end
  
  end

end
