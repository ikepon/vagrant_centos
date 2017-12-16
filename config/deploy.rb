# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "isetan"
set :repo_url, "git@github.com:ikepon/isetan.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/isetan"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

def set_vagrant_user
  ssh_config = {}
  Bundler.with_clean_env do
    out = `vagrant ssh-config`
    out.split("\n").each do |line|
      line.strip!
      key, value = line.split(" ", 2)
      value.slice!(0) if value.start_with?('"')
      value.slice!(-1) if value.end_with?('"')
      ssh_config[key] = value
    end
  end

  set :user, ssh_config["User"]
  set :ssh_options,
    user: ssh_config["User"],
    port: ssh_config["Port"],
    keys: [ssh_config["IdentityFile"]],
    forward_agent: ssh_config["ForwardAgent"] == "yes" ? true : false
end
