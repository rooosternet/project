source 'https://rubygems.org'

ruby '2.2.0'
gem 'rails', '4.2.4'

# gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
gem 'susy'

gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'will_paginate', '~> 3.0'
gem 'devise'
# gem 'devise', path: "vendor/devise"
gem 'devise_invitable'
# gem 'devise_invitable', path: "vendor/devise_invitable"
gem 'high_voltage'
gem 'mysql2', '~> 0.3.18'
gem 'pundit'
gem 'whenever', :require => false
gem 'roo'
gem 'faye-websocket', '0.10.0'
gem 'websocket-rails'

gem 'autosize-rails'

#integrations
gem 'behance'
gem 'dribbble', '~> 1.0', '>= 1.0.4'
gem 'vimeo'
gem 'linkedin-scraper'

gem 'omniauth'
gem 'omniauth-twitter'
gem "omniauth-vimeo"
# gem 'omniauth-vimeo-oauth2'
gem 'omniauth-linkedin'
#gem 'omniauth-behance'
gem 'omniauth-behance', path: "vendor/omniauth_behance"
gem 'omniauth-dribbble', '~> 0.0.1'

gem 'redis', '~>3.2'

gem 'acts_as_tree', '~> 2.4'
gem 'carrierwave'
gem 'mini_magick', '~> 4.5', '>= 4.5.1'

# gem 'avatars_for_rails', path: "vendor/avatars_for_rails"

# gem 'sidekiq' , '=3.3.1'#github: "mperham/sidekiq"
# gem 'sinatra','>= 1.3.0', :require => false
# gem 'sprockets'
# gem 'sidekiq-failures'
gem 'sprockets', '3.6.3'
# require 'erb'
# require 'yaml'

group :production do
  # gem 'unicorn'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'better_errors'
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm', '~> 0.1.1'
  gem 'capistrano-websocket-rails'
  # gem 'capistrano-sidekiq'
  # gem 'guard-bundler'
  # gem 'guard-rails'
  # gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development, :test, :staging do
  gem 'byebug'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end
