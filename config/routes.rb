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

  resources :users do
    collection do
      post 'batch_invite'
    end
    # member do
    #   post 'update_avatars'
    # end
  end
  post 'users/:id/update_avatars', :controller => :users , :action => :update_avatars , :as => "update_avatars"
  get 'users/:id/profile', :controller => :users , :action => :profile , :as => "profile"
  post 'users/:id/update_profile_image', :controller => :users , :action => :update_profile_image , :as => "update_profile_image"
  get '/accepting_invitation', :controller => :users, :action => :accepting_invitation , :as => "accepting_invitation"
  get '/canceled_invitation', :controller => :users, :action => :canceled_invitation , :as => "canceled_invitation"
  get '/set_group_admin', :controller => :users, :action => :set_group_admin, :as => 'set_group_admin'

  post 'teams/:id/update_team_avatar' , :controller => :teams , :action => :update_team_avatar , :as => "update_team_avatar"

  # match 'account/register', :to => 'account#register', :via => [:post,:get], :as => 'register'
  resources :in_messages
  get 'in_messages/:token', :controller => :in_messages , :action => :show , :as => "message_show"
  post 'in_messages/:id/touch' , :controller => :in_messages , :action => :touch , :as => "message_touch"
  post 'in_messages/archive' , :controller => :in_messages , :action => :archive , :as => "message_archive"
  post "in_messages/bulk_create",:controller => :in_messages, :action => :bulk_create ,:as => :bulk_create_message
  post "in_messages/bulk_create_chat_message",:controller => :in_messages, :action => :bulk_create_chat_message ,:as => :bulk_create_chat_message
  match 'inbox', :to => 'in_messages#index', :via => [:get], :as => 'inbox'

  resources :teams
  post 'teams/remove_profile', :as => "remove_profile"
  post 'teams/archive' , :as => "team_archive"

  post 'teams/update_teams_order' , :as => "update_teams_order"

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
