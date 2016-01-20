require 'capistrano/setup'
require 'capistrano/deploy'

task :docker do
  require 'capistrano/docker'
  require 'capistrano/docker/npm'
  require 'capistrano/docker/assets'
  require 'capistrano/docker/migration'
end

task :non_docker do
  require 'capistrano/bundler'
  require 'capistrano/npm'
  require 'capistrano/rails/assets'
  require 'capistrano/rails/migrations'
  require 'capistrano/passenger'
  require 'rvm1/capistrano3'
  require 'whenever/capistrano'
end

task 'production' => [:non_docker]
task 'docker_production' => [:docker]
