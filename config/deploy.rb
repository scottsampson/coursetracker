set :application, "coursetracker"

set :deploy_to, "/srv/apps/#{application}"
set :scm, :git
set :repository,  "git@github.com:scottsampson/coursetracker.git"
set :deploy_via, :remote_cache
set :keep_releases, 10
default_run_options[:pty] = true 

set :ssh_options, { :forward_agent => true, :user => "ubuntu" }
set :user, "ubuntu"
set :use_sudo, false

set :default_environment, {
  'RAILS_ENV' => 'production'
}

role :web, "184.72.234.156"
role :app, "184.72.234.156"
role :db, "184.72.234.156", :primary => true

set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
set :daemon_pid, "#{shared_path}/pids/aws_statusd.pid"

namespace :deploy do
  task :restart do
    deploy.stop
    deploy.start
  end
  
  task :start do
    run "cd #{current_path} && sudo bundle exec unicorn -E production -c #{current_path}/config/unicorn.rb -D"
  end
  
  task :stop do
    run "sudo kill `cat #{unicorn_pid}`"
  end

  task :migrate do
    run "cd #{current_path} && rake db:migrate"
  end

  task :setup_sockets_dir do
    run "mkdir #{shared_path}/sockets"
  end

  task :symlink_sockets_dir do
    run "ln -s #{shared_path}/sockets #{current_path}/tmp/sockets"
  end
end

namespace :bundler do
  task :install, :roles => :app do
    run "cd #{release_path} && sudo bundle install --without=development"
    
    on_rollback do
      if previous_release
        run "cd #{previous_release} && sudo bundle install --without=development"
      else
        logger.important "no previous release to rollback to, rollback of bundler:install skipped"
      end
    end
  end

  task :ensure_bundler_installed, :roles => :app do
    run '[ -z $(gem list bundler | tail -1) ] && sudo gem install bundler || echo "Bundler already installed"'
  end
end

after "deploy:setup", "deploy:setup_sockets_dir"
after "deploy:setup", "bundler:ensure_bundler_installed"
after "deploy:update_code", "bundler:install"
after "deploy:symlink", "deploy:symlink_sockets_dir"
after "deploy:symlink", "deploy:migrate"

