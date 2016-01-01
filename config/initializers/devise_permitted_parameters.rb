module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name,:firstname, :lastname ,:edit_profile, :email2 ]
    # devise_parameter_sanitizer.for(:account_update) << [:id,:edit_profile,:name,:email,:email2,:firstname,:lastname, studio_attributes: [:id,:email , :job_title ,:company_name ,:company_website,:location, :social_links] ,  freelancer_attributes: [:id,:email ,:online_portfolio,:linkedin_profile,:company_name,:contact_name,:contact_email,:behance,:vimeo,:skills,:location]]
    devise_parameter_sanitizer.for(:account_update) << [:id,:edit_profile,:name,:email,:email2,:firstname,:lastname, profile_attributes: [:id,:searchable,:public_email,:location,:job_title,:company_name,:company_website,:online_portfolio,:linkedin_profile,:behance,:vimeo,:social_links,:skills]]
    devise_parameter_sanitizer.for(:invite) << [:firstname,:lastname,:email]
  end

end

DeviseController.send :include, DevisePermittedParameters




 