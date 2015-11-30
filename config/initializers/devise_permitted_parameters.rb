module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << [:id,:name,:email,:email2,:firstname,:lastname, studio_attributes: [:job_title ,:company_name ,:company_website] ,  freelancer_attributes: [:id,:online_portfolio,:linkedin_profile,:company_name,:contact_name,:contact_email,:behance,:vimeo,:skills,:location]]
  end

end

DeviseController.send :include, DevisePermittedParameters
