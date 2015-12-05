Rails.application.routes.draw do
  get 'freelancers/index'
  post 'freelancers/invite'

  root to: 'visitors#home'
  # devise_for :users

  devise_for :users, controllers: {
        registrations: "users/registrations"
  }, 
  :path_names => { :sign_up => "account/register" }
  

  resources :users
  match 'account/register', :to => 'account#register', :via => [:post,:get], :as => 'register'

end