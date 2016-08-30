# Load DSL and Setup Up Stages
require 'capistrano/setup'
# Includes default deployment tasks
require 'capistrano/deploy'
require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails'
require 'capistrano/rails/migrations'
# require 'capistrano/whenever'
# require 'capistrano/sidekiq'
require "whenever/capistrano"
#require 'sidekiq/capistrano'
require 'capistrano/websocket-rails'


# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

desc "Check if agent forwarding is working"
task :forwarding do
	on roles(:all) do |h|
		if test("env | grep SSH_AUTH_SOCK")
			info "Agent forwarding is up to #{h}"
		else
			error "Agent forwarding is NOT up to #{h}"
		end
	end
end


desc "Check that we can access everything"
task :check_write_permissions do
	on roles(:all) do |host|
		if test("[ -w #{fetch(:deploy_to)} ]")
			info "#{fetch(:deploy_to)} is writable on #{host}"
		else
			error "#{fetch(:deploy_to)} is not writable on #{host}"
		end
	end
end

desc "Report Uptimes"
task :uptime do
	on roles(:all) do |host|
		info "Host #{host} (#{host.roles.join(', ')}):\t#{capture(:uptime)}"
	end
end

namespace :rvm do

	desc "Set default rvm ruby version"
	task :set_rvm_version do
		on roles(:app) do
			execute "source /etc/profile.d/rvm.sh && rvm use #{fetch(:rvm_ruby_version)} --default"
		end
	end

end


namespace :cache do
  desc "Clear memcach after deployment"
	task :clear do
		on roles(:app) do
			within release_path do
				with rails_env: fetch(:rails_env) do
					execute :rake, "cache:clear_memcached"
				end
			end
		end
	end
end


namespace :roooster do

	desc 'Chown application root directory'
	task :chown_root_dir do
		on roles(:app) do
			user = fetch(:ssh_options)[:user]
			command = "sudo chown -R #{user}:#{user} #{fetch(:deploy_to)}/;true;"
			info "Executing command: #{command}"
			execute command
		end
	end
end






namespace :deploy do

	desc 'Restart application'
		task :restart do
			on roles(:app), in: :sequence, wait: 5 do
	      # Your restart mechanism here, for example:
	      execute :touch, release_path.join('tmp/restart.txt')
	  end
	end

	task :check_byebug do
		run_locally do
			command = "grep -r 'byebug' app plugins lib | grep -v '#.*byebug'"
			value = `#{command}`
			if value != ""
				error "YOU ARE DEPLOYING WITH BYEBUG \n " + `#{command}`
				exit 1
			end
		end
	end

	after :restart, :clear_cache do
		on roles(:web), in: :groups, limit: 3, wait: 10 do
	      # Here we can do anything such as:
	      # within release_path do
	      #   execute :rake, 'cache:clear'
	      # end
	  end
	end



	task :quick do
		set :skip_migrate, true
		set :skip_plugin_migrate, true
		invoke "deploy"
	end

	task :upgrade do
		set :run_post, true
		invoke "deploy"
	end

	task :notify_deploy do
		`say "rooster #{fetch(:rails_env)} deploy completed, kokoureeku"`
	end

	 task :clear_assets do
	  on roles(:app), in: :sequence, wait: 5 do
	      path = release_path.join('public/assets/*')
	      command = "rm -rf #{path}"
	      info "Executing command: #{command}"
	      execute command
	    end
	  end


  	# before :starting, 'deploy:clear_assets'
	before :starting, 'deploy:check_byebug'
	after :finishing, 'deploy:cleanup'
	after :finishing, 'roooster:chown_root_dir'
	after 'deploy:finished', 'deploy:notify_deploy'
	after 'deploy:publishing', 'deploy:restart'

end


namespace :rake do
	desc "Run a task on a remote server."
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
  	run_remote_rake(ENV['task'])
  end
end

# check if remote file exist
def remote_file_exists?(full_path)
	'true' == capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

def run_remote_rake(rake_cmd, failsafe = false)
	rake = fetch(:rake, "rake")
	command = "cd #{latest_release}; #{rake} RAILS_ENV=#{rails_env} #{rake_cmd.split(',').join(' ')}"
	command << '; true' if failsafe
	execute command
end

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
