lock "~> 3.18.0"

set :application, "junction"

# set :repo_url, "git@github.com:vimeto/junction-2023-api.git"
set :repo_url, "git@github.com:vimeto/junction-2023-api.git"

# set :scm, :git
# set :branch, "main"
# set :repository_cache, "git_cache"
# set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# Only keep the last 5 releases to save disk space
set :keep_releases, 5
