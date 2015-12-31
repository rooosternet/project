Rails.application.routes.draw do
  get 'errors/show'

  get 'freelancers/index'
  post 'freelancers/invite'

  get 'visitors/home', :as => "home"

  root to: 'visitors#home'
  # devise_for :users

  devise_for :users, controllers: {
        registrations: "users/registrations",
        sessions: "users/sessions",
        passwords: "users/passwords",
        invitations: "users/invitations",
        confirmations: "users/confirmations"
  }#,:path_names => { :sign_up => "account/register" }
  

  resources :users
  # match 'account/register', :to => 'account#register', :via => [:post,:get], :as => 'register'


  get 'info/about', :as => "about"
  get 'info/blog', :as => "blog"
  get 'info/faq', :as => "faq"
  get 'info/privacy', :as => "privacy"
  get 'info/terms', :as => "terms"
   

  # error pages
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#show", :code => code
  end
    
end