Rails.application.routes.draw do

  get 'errors/show'
  get 'profiles/index'
  post 'profiles/invite'
  post "profiles/:id/contact",:controller => :profiles, :action => :contact,:as => :contact

  get 'visitors/home', :as => "home"

  root to: 'visitors#home'
  # devise_for :users

  devise_for :users, controllers: {
        registrations: "users/registrations",
        sessions: "users/sessions",
        passwords: "users/passwords",
        invitations: "users/invitations",
        confirmations: "users/confirmations",
        omniauth_callbacks: "users/omniauth_callbacks"
  }#,:path_names => { :sign_up => "account/register" }
  
  resources :users
  resources :profile_connects
  
  # match 'account/register', :to => 'account#register', :via => [:post,:get], :as => 'register'
  resources :in_messages
  get 'in_messages/:token', :controller => :in_messages , :action => :show , :as => "message_show"
  match 'inbox', :to => 'in_messages#index', :via => [:get], :as => 'inbox'
  
  get 'info/about', :as => "about"
  get 'info/blog', :as => "blog"
  # get 'info/post/:name', :controller => :info , :action => :post , :as => "post"
  get 'info/faq', :as => "faq"
  get 'info/privacy', :as => "privacy"
  get 'info/terms', :as => "terms"
  
  match 'info/contact_us' , :to => 'info#contact_us', :via => [:post,:get], :as => 'contact_us'

  # error pages
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#show", :code => code
  end
    
end