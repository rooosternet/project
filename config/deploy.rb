# config valid only for Capistrano 3.1
# lock '3.2.1'
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
# Default value for :pty is false
# set :pty, true
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :application, 'roooster'
set :scm, :git
set :format, :pretty
set :repo_url, 'git@github.com:rooosterteam/roooster.git'
set :linked_dirs, %w{bin log tmp vendor/bundle public/system files public/uploads}
set :linked_files, %w{config/database.yml config/secrets.yml config/initializers/session_store.rb config/omniauth.yml} 

# set :bundle_bins, fetch(:bundle_bins, []).push('my_new_binary')
# set :bundle_roles, :all                                         # this is default
# set :bundle_servers, -> { release_roles(fetch(:bundle_roles)) } # this is default
# set :bundle_binstubs, -> { shared_path.join('bin') }            # this is default
# set :bundle_gemfile, -> { release_path.join('Gemfile') }        # default: nil
# set :bundle_path, -> { shared_path.join('bundle') }             # this is default
# set :bundle_without, %w{development test}.join(' ')             # this is default
set :bundle_flags, '--deployment '                       # this is default '--deployment --quiet' 
# set :bundle_env_variables, {}                                   # this is default

# set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
# set :whenever_environment, ->{ "#{fetch(:stage)}" }

# set :sidekiq_processes , 1
# set :sidekiq_options, ->{ "-e #{fetch(:stage)} -C #{current_path}/config/sidekiq.yml -L #{current_path}/log/sidekiq.log" }

set :rvm_type, :system
set :rvm_map_bins ,  %w{bundle gem rake ruby whenever sidekiq sidekiqctl}
set :rvm_custom_path, "/usr/local/rvm/" #/usr/local/rvm/scripts/rvm
set :rvm_ruby_version, '2.2.0' 


# set :rails_env, 'staging'                  # If the environment differs from the stage name
# set :migration_role, 'migrator'            # Defaults to 'db'
# set :conditionally_migrate, true           # Defaults to false. If true, it's skip migration if files in db/migrate not modified
# set :assets_roles, [:web, :app]            # Defaults to [:web]
# set :assets_prefix, 'prepackaged-assets'   # Defaults to 'assets' this should match config.assets.prefix in your rails config/application.rb
# If you need to touch public/images, public/javascripts and public/stylesheets on each deploy:
set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}


# after :published, 'sidekiq:restart'

SSHKit.config.command_map[:rake] = "bundle exec rake"
# SSHKit.config.command_map[:whenever] = "bundle exec whenever"
# SSHKit.config.command_map[:sidekiq] = "bundle exec sidekiq"
# SSHKit.config.command_map[:sidekiqctl] = "bundle exec sidekiqctl"

# before "sidekiq:start" , 'rvm:hook'
# before "sidekiq:stop" , 'rvm:hook'
# before "sidekiq:quiet" , 'rvm:hook'

