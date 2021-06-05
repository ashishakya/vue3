server "vue.ashishakya.com.np",
user: 'ubuntu',
roles: %w{web app},
port: 22

# Directory to deploy
# ===================
set :env, 'staging'
set :app_debug, 'false'
set :deploy_to, '/home/ubuntu/vue'
set :shared_path, '/home/ubuntu/vue/shared'
set :overlay_path, '/home/ubuntu/vue/overlay'
set :tmp_dir, '/home/ubuntu/vue/tmp'
set :site_url, 'vue.ashishakya.com.np'
