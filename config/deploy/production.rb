server ENV['PRODUCTION_SERVER'], user: ENV['PRODUCTION_USER'], roles: %w(web app db)
set :branch, 'production'

set :docker_volumes, [
  "#{shared_path}/config/secrets.yml:/var/www/app/config/secrets.yml",
  "#{shared_path}/log:/var/www/app/log",

  "props_production_node_modules:/var/www/app/node_modules",
  "props_production_assets:/var/www/app/public/assets",
  "#{shared_path}/assets/javascripts/react_bundle.js:/var/www/app/app/assets/javascripts/react_bundle.js",
]

set :docker_links, %w(postgres_ambassador:postgres redis_ambassador:redis)
set :docker_additional_options, -> { "--env-file #{shared_path}/envfile" }
set :docker_dockerfile, "docker/production/Dockerfile"

set :docker_apparmor_profile, "docker-ptrace"
set :docker_cpu_quota, "200000"

namespace :docker do
  namespace :npm do
    task :build do
      on roles(fetch(:docker_role)) do
        execute :docker, task_command("npm run build")
      end
    end
  end
end

after "docker:npm:install", "docker:npm:build"
