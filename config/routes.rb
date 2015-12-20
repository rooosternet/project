Rails.application.routes.draw do
  get 'freelancers/index'
  post 'freelancers/invite'

  get 'visitors/home', :as => "home"

  root to: 'visitors#home'
  # devise_for :users

  devise_for :users, controllers: {
        registrations: "users/registrations"
  }, 
  :path_names => { :sign_up => "account/register" }
  

  resources :users
  match 'account/register', :to => 'account#register', :via => [:post,:get], :as => 'register'


  get 'info/about', :as => "about"
  get 'info/blog', :as => "blog"
  get 'info/faq', :as => "faq"
  get 'info/privacy', :as => "privacy"
  get 'info/terms', :as => "terms"
    
end