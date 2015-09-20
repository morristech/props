lock '3.3.5'

set :application, 'props'
set :repo_url,  'git://github.com/netguru/props.git'
set :deploy_to, ENV['DEPLOY_PATH']

set :linked_files, %w(config/database.yml config/secrets.yml)
set :linked_dirs, %w(bin log tmp vendor/bundle)

namespace :webpack do
  task :build do
    on roles :web do
      within release_path do
        execute :bundle, 'exec npm run build'
      end
    end
  end
end

after 'npm:install', 'webpack:build'
