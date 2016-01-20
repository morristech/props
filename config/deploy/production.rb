require 'net/ssh/proxy/command'
server ENV['PRODUCTION_SERVER'], user: ENV['PRODUCTION_USER'], roles: %w(web app db)
set :ssh_options, proxy: Net::SSH::Proxy::Command.new("ssh #{ENV['GATEWAY']} -W %h:%p")
set :branch, 'production'

set :linked_files, %w(config/database.yml config/secrets.yml)
set :linked_dirs, %w(bin log tmp vendor/bundle node_modules)

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
