server ENV['STAGING_SERVER'], user: ENV['STAGING_USER'], roles: %w[app db web]
set :branch, ENV['REVISION'] || 'master'
set :deploy_to, "/home/deploy/apps/#{fetch(:application)}"

set :default_env, lambda {
  {
    'TIMESTAMP' => release_timestamp,
    'DOCKER_REPO' => ENV['DOCKER_REPO'],
    'VIRTUAL_HOST' => ENV['VIRTUAL_HOST'],
  }
}

set :capose_project, -> { "#{fetch(:application)}-prerun" }
set :capose_commands, -> {
  [
    'run --rm web bundle exec rake assets:precompile',
    'run --rm web bundle exec rake db:migrate',
    'down',
  ]
}

before 'capose:deploy', 'docker:push_image'
after 'capose:deploy', 'docker:stack_deploy'
