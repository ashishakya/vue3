# lock '3.7.2'

# Application #
#####################################################################################
set :application,     "Blingg"
set :branch,          ENV["branch"] || "master"
set :user,            ENV["user"] || ENV["USER"] || "vue"

# SCM #
#####################################################################################
set :repo_url,        :'git@github.com:ashishakya/vue3.git'
set :repo_base_url,   :'https://github.com'
# @todo
# set :repo_diff_path,  :'web-apps/guy_wali-support-to-lg-tdh/compare/master...'
# set :repo_branch_path,:'web-apps/guy_wali-support-to-lg-tdh/commits'
# set :repo_commit_path,:'web-apps/guy_wali-support-to-lg-tdh/commit'

# Multistage Deployment #
#####################################################################################
set :stages,              %w(staging production)
set :default_stage,       "staging"

# Other Options #
#####################################################################################
set :ssh_options,         { :forward_agent => true }
# set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/guy_wali_dev_bling/id_rsa) }

set :default_run_options, { :pty => true }

# Permissions #
#####################################################################################
set :use_sudo,            false
set :permission_method,   :acl
set :use_set_permissions, true
set :webserver_user,      "www-data"
set :group,               "www-data"
set :keep_releases,       1

# Slack Integration #
#####################################################################################
#set :slack_webhook_url,     ""

# Rollbar Integration #
#####################################################################################
set :rollbar_env, Proc.new { fetch :stage }
set :rollbar_role, Proc.new { :app }

# Set current time #
#######################################################################################
require 'date'
set :current_time, DateTime.now
set :current_timestamp, DateTime.now.to_time.to_i

# Application Tasks #
#######################################################################################
namespace :environment do
    desc "Set environment variables"
    task :set_variables do
        on roles(:app) do
              puts ("--> Copying environment configuration file")
              execute "cp #{release_path}/.env.server #{release_path}/.env"
              puts ("--> Setting environment variables")
              execute "sed --in-place -f #{fetch(:overlay_path)}/parameters.sed #{release_path}/.env"
        end
    end
end

namespace :composer do
    desc "Running Composer Install"
    task :install do
        on roles(:app) do
            within release_path do
                execute :composer, "install --quiet"
                execute :composer, "dump-autoload -o"
            end
        end
    end
end

namespace :guy_wali do
    desc "Create shared folders"
    task :create_storage_folder do
        on roles(:all) do
            execute "mkdir -p #{shared_path}/storage"
            execute "mkdir #{shared_path}/storage/app"
            execute "mkdir #{shared_path}/storage/framework"
            execute "mkdir #{shared_path}/storage/framework/cache"
            execute "mkdir #{shared_path}/storage/framework/sessions"
            execute "mkdir #{shared_path}/storage/framework/views"
            execute "mkdir #{shared_path}/storage/logs"
        end
    end

    task :create_overlay_folder do
        on roles(:all) do
            execute "mkdir -p #{deploy_to}/overlay"
        end
    end

    task :create_uploads_folder do
        on roles(:all) do
            execute "mkdir #{shared_path}/uploads"
        end
    end

    task :create_imports_folder do
        on roles(:all) do
            execute "mkdir #{shared_path}/imports"
        end
    end

    desc "Move files from imports to shared/imports"
    task :move_static_images do
        on roles(:all) do
            execute "cp -Rpf #{release_path}/public/blingg #{shared_path}/public/"
        end
    end

    desc "Symbolic link for shared folders"
    task :create_symlink do
        on roles(:app) do
            within release_path do
                execute "rm -rf #{release_path}/storage"
                execute "ln -s #{shared_path}/storage/ #{release_path}"

                execute "rm -rf #{release_path}/public/storage"
                execute "ln -s #{shared_path}/storage #{release_path}/public"
            end
        end
    end

    desc "Run Laravel Artisan migrate task."
    task :migrate do
        on roles(:app) do
            within release_path do
                execute :php, "artisan migrate --force"
            end
        end
    end

    desc "Run Laravel Artisan migrate fresh task."
    task :migrate_fresh do
        on roles(:app) do
            within release_path do
                execute :php, "artisan migrate:fresh --seed --force"
            end
        end
    end

    desc "Run Laravel Artisan seed task."
    task :seed do
        on roles(:app) do
            within release_path do
            execute :php, "artisan db:seed --force"
            end
        end
    end

    desc "Optimize Laravel Class Loader"
    task :optimize do
        on roles(:app) do
            within release_path do
                execute :php, "artisan clear-compiled"
                execute :php, "artisan optimize"
            end
        end
    end

    desc "Create ver.txt"
    task :create_ver_txt do
        on roles(:all) do
            puts ("--> Copying ver.txt file")
            execute "cp #{release_path}/config/deploy/ver.txt.example #{release_path}/public/ver.txt"
            execute "sed --in-place 's/%date%/#{fetch(:current_time)}/g
                        s/%branch%/#{fetch(:branch)}/g
                        s/%revision%/#{fetch(:current_revision)}/g
                        s/%deployed_by%/#{fetch(:user)}/g' #{release_path}/public/ver.txt"
            execute "find #{release_path}/public -type f -name 'ver.txt' -exec chmod 664 {} \\;"
        end
    end

end

# DevOps Tasks #
#######################################################################################
namespace :devops do
    desc "Setup Application Directories"
    task :set_up do
        on roles(:all) do
            invoke "guy_wali:create_storage_folder"
            invoke "guy_wali:create_overlay_folder"
            invoke "guy_wali:create_uploads_folder"
            invoke "guy_wali:create_imports_folder"
        end
    end

    desc "Copy Parameter File(s)"
    task :copy do
        on roles(:all) do |host|
            %w[ parameters.sed ].each do |f|
            upload! "./config/deploy/parameters/#{fetch(:env)}/" + f , "#{fetch(:overlay_path)}/" + f
            end
        end
    end

    desc "Get Current Release Information"
    task :app_ver do
        on roles(:all) do
           execute "curl #{fetch(:site_url)}/ver.txt"
        end
    end
end

namespace :vendor do
    desc 'Copy vendor directory from last release'
    task :copy do
        on roles(:web) do
            puts ("--> Copy vendor folder from previous release")
            execute "vendorDir=#{current_path}/vendor; if [ -d $vendorDir ] || [ -h $vendorDir ]; then cp -a $vendorDir #{release_path}/vendor; fi;"
        end
    end
end

# Slack Tasks #
#######################################################################################
namespace :slack do
    desc 'Test Slack Incoming Webhook'
    task :test do
        on roles(:all) do
            execute "curl -s -X POST -H 'Content-type: application/json' --data '{\"text\":\"Hello! from the other side.\\nSee you later!\"}' #{fetch(:slack_webhook_url)}"
        end
    end

    desc 'Notify Slack'
    task :notify do
        on roles(:all) do
            execute "curl -s -X POST -H 'Content-type: application/json' --data '{\"attachments\":[{\"fallback\":\"#{fetch(:notify_message)}\",\"color\":\"#{fetch(:notify_color)}\",\"pretext\":\"\",\"title\":\"#{fetch(:job_title)}\",\"title_link\":\"\",\"text\":\"#{fetch(:notify_message)}\",\"fields\":[{\"title\":\"Server URL\",\"value\":\"#{fetch(:site_url)}\",\"short\":false},{\"title\":\"Server\",\"value\":\"#{fetch(:env).upcase}\",\"short\":true},{\"title\":\"Branch\",\"value\":\"<#{fetch(:repo_base_url)}/#{fetch(:repo_branch_path)}/#{fetch(:branch)}|#{fetch(:branch)}> | <#{fetch(:repo_base_url)}/#{fetch(:repo_diff_path)}#{fetch(:branch)}|View Comparison>\",\"short\":true},{\"title\":\"Deployed By\",\"value\":\"#{fetch(:user)}\",\"short\":true},{\"title\":\"Commit SHA\",\"value\":\"#{fetch(:commit_detail)}\",\"short\":true}],\"image_url\":\"\",\"thumb_url\":\"\",\"footer\":\"<http://capistranorb.com|Capistrano>\",\"footer_icon\":\"https://pbs.twimg.com/profile_images/378800000067686459/5da4e1d78e930197cb7dc002ceafdfda.png\",\"ts\":#{fetch(:current_timestamp)}}]}' #{fetch(:slack_webhook_url)}"
            Rake::Task["slack:notify"].reenable
        end
    end

    desc 'Slack notification on deployment start'
    task :start do
        on roles(:all) do
            set :job_title, "Deployment Started for #{fetch(:application)}"
            set :notify_message, "#{fetch(:user)} is deploying #{fetch(:application)}/#{fetch(:branch)} to #{fetch(:env)}."
            set :notify_color, "#FA9040"
            set :commit_detail, "N/A"
            execute "curl -s -X POST -H 'Content-type: application/json' --data '{\"attachments\":[{\"fallback\":\"#{fetch(:notify_message)}\",\"color\":\"#{fetch(:notify_color)}\",\"pretext\":\"\",\"title\":\"#{fetch(:job_title)}\",\"title_link\":\"\",\"text\":\"#{fetch(:notify_message)}\",\"image_url\":\"\",\"thumb_url\":\"\",\"footer\":\"<http://capistranorb.com|Capistrano>\",\"footer_icon\":\"https://pbs.twimg.com/profile_images/378800000067686459/5da4e1d78e930197cb7dc002ceafdfda.png\",\"ts\":#{fetch(:current_timestamp)}}]}' #{fetch(:slack_webhook_url)}"
        end
    end

   desc 'Slack notification on .env parameters update'
    task :env_updating do
        on roles(:all) do
            set :job_title, "Environment Parameters Updating for #{fetch(:application)}"
            set :notify_message, "#{fetch(:user)} is updating environment parameters of #{fetch(:env)} site."
            set :notify_color, "#FA9040"
            set :commit_detail, "N/A"
            execute "curl -s -X POST -H 'Content-type: application/json' --data '{\"attachments\":[{\"fallback\":\"#{fetch(:notify_message)}\",\"color\":\"#{fetch(:notify_color)}\",\"pretext\":\"\",\"title\":\"#{fetch(:job_title)}\",\"title_link\":\"\",\"text\":\"#{fetch(:notify_message)}\",\"image_url\":\"\",\"thumb_url\":\"\",\"footer\":\"<http://capistranorb.com|Capistrano>\",\"footer_icon\":\"https://pbs.twimg.com/profile_images/378800000067686459/5da4e1d78e930197cb7dc002ceafdfda.png\",\"ts\":#{fetch(:current_timestamp)}}]}' #{fetch(:slack_webhook_url)}"
        end
    end

   desc 'Slack notification on .env update completion'
    task :env_updated do
        on roles(:all) do
            set :job_title, "Environment parameters successfully updated for #{fetch(:application)}."
            set :notify_message, "#{fetch(:user)} finished updating environment parameters to #{fetch(:env)}."
            set :notify_color, "#36A64F"
            set :commit_detail, "<#{fetch(:repo_base_url)}/#{fetch(:repo_commit_path)}/#{fetch(:current_revision)}|#{fetch(:current_revision)}>"
            invoke "slack:notify"
        end
    end

    desc 'Slack notification on deployment completion'
    task :deployed do
        on roles(:all) do
            set :job_title, "Deployment Completed for #{fetch(:application)}"
            set :notify_message, "#{fetch(:user)} finished deploying #{fetch(:application)}/#{fetch(:branch)} to #{fetch(:env)}."
            set :notify_color, "#36A64F"
            set :commit_detail, "<#{fetch(:repo_base_url)}/#{fetch(:repo_commit_path)}/#{fetch(:current_revision)}|#{fetch(:current_revision)}>"
            invoke "slack:notify"
        end
    end

    desc 'Slack notification on deployment failed'
    task :notify_deploy_failed do
        on roles(:all) do
            set :job_title, "Deployment Failed for #{fetch(:env)}"
            set :notify_message, "Error deploying branch. Check capistrano.log file."
            set :notify_color, "#FF0000"
            set :commit_detail, "<#{fetch(:repo_base_url)}/#{fetch(:repo_commit_path)}/#{fetch(:current_revision)}|#{fetch(:current_revision)}>"
            invoke "slack:notify"
        end
    end
end

# Server Tasks #
#######################################################################################
namespace :nginx do
    desc 'Reload nginx server'
        task :reload do
            on roles(:all) do
            execute :sudo, :service, "nginx reload"
        end
    end
end

namespace :php_fpm do
    desc 'Reload php-fpm'
        task :reload do
            on roles(:all) do
            execute :sudo, :service, "php7.4-fpm reload"
        end
    end
end

namespace :php_fpm do
    desc 'Restart php-fpm'
        task :restart do
            on roles(:all) do
            execute :sudo, :service, "php7.4-fpm restart"
        end
    end
end

namespace :laravel_queue do
    desc 'Restart Supervisor Laravel Queue Task'
        task :restart do
            on roles(:all) do
            execute :sudo, :supervisorctl, "restart #{fetch(:supervisor_task)}"
        end
    end
    desc 'Strat Supervisor Laravel Queue Task'
        task :start do
            on roles(:all) do
            execute :sudo, :supervisorctl, "start #{fetch(:supervisor_task)}"
        end
    end
    desc 'Stop Supervisor Laravel Queue Task'
        task :stop do
            on roles(:all) do
            execute :sudo, :supervisorctl, "stop #{fetch(:supervisor_task)}"
        end
    end
end

#######################################################################################

namespace :application do
    desc 'Clear Application Cache'
    task :cache_clear do
        on roles(:all) do
            within release_path do
                execute :php, "artisan cache:clear"
            end
        end
    end
end

# Installation Tasks #
#######################################################################################
namespace :installation do
      desc "Running yarn install"
          task :yarn_install do
              on roles(:app) do
                  within release_path do
                      puts ("--> Installing npm packages")
#                       execute :nvm, "use 12"
                      execute :yarn
                  end
              end
          end

      desc "Build application"
          task :yarn_build do
              on roles(:all) do
                  within release_path do
                      puts ("--> Building for production")
                      execute :yarn, "prod"
                  end
              end
          end
end

#############################################

desc "Setup Initialize"
task :setup do
    invoke "devops:set_up"
    invoke "devops:copy"
end

desc "Update Environment File"
task :update_env do
    #invoke "slack:env_updating"
    invoke "devops:copy"
    invoke "environment:set_variables"
   # invoke "slack:env_updated"
end

desc "Get Current Release Information"
task :app_ver do
    invoke "devops:app_ver"
end

desc "Reload Server"
task :reload_server do
    invoke "nginx:reload"
    invoke "php_fpm:reload"
end

namespace :deploy do
    #after :starting, "slack:start"
#    after :starting, "laravel_queue:stop"
#     after :updated, "vendor:copy"
#     after :updated, "composer:install"
    after :updated, "environment:set_variables"
#     after :updated, "installation:yarn_install"
#     after :updated, "installation:yarn_build"
#     after :published, "guy_wali:move_static_images" #Make sure to call this before creating symlink
#     after :published, "guy_wali:create_symlink"
    after :finished, "guy_wali:create_ver_txt"
    #after :finished, "slack:deployed"
#     after :finished, "application:cache_clear"
    #after :failed, "slack:notify_deploy_failed"
#   after :failed, "laravel_queue:start"
end

#before "deploy", "laravel_queue:stop"

#after "deploy", "nginx:reload"
# after "deploy", "php_fpm:reload"
# after "deploy", "laravel_queue:restart"
#after "deploy", "laravel_queue:start"
