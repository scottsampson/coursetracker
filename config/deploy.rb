set :application, "coursetracker"
set :repository,  "git@github.com:scottsampson/coursetracker.git"

set :user, "root"

set :deploy_to, "/srv/#{application}"

set :deploy_via, :remote_cache
default_run_options[:pty] = true 

set :ssh_options, { :forward_agent => true, :user => "ubuntu" }

set :scm, :git

role :web, "184.72.234.156"
role :app, "184.72.234.156"
role :db, "184.72.234.156", :primary => true

set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
set :daemon_pid, "#{shared_path}/pids/aws_statusd.pid"

namespace :deploy do
  task :restart do
    run "kill -USR2 `cat #{unicorn_pid}`"
  end
  
  task :start do
    run "cd #{current_path} && bundle exec unicorn -E production -c #{current_path}/config/unicorn.rb -D"
  end
  
  task :stop do
    run "kill `cat #{unicorn_pid}`"
  end

  task :migrate do
    run "cd #{current_path} && rake db:migrate"
  end
end

namespace :bundler do
  task :install, :roles => :app do
    run "cd #{release_path} && bundle install"
    
    on_rollback do
      if previous_release
        run "cd #{previous_release} && bundle install"
      else
        logger.important "no previous release to rollback to, rollback of bundler:install skipped"
      end
    end
  end

  task :ensure_bundler_installed, :roles => :app do
    run '[[ -z $(gem list bundler | tail -1) ]] && gem install bundler || echo "Bundler already installed"'
  end
end

after "deploy:setup", "bundler:ensure_bundler_installed"
after "deploy:update_code", "bundler:install"
after "deploy:symlink", "deploy:migrate"

