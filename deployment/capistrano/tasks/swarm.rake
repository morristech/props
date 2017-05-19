set :image, -> { "#{ENV["DOCKER_REPO"]}:#{release_timestamp}" }
set :dockerfile, -> { "docker/staging/Dockerfile" }

task "docker:push_image" do
  on roles(fetch(:capose_role)) do
    within release_path do
      ## build the image
      execute :docker, "build -t #{fetch(:image)} -f #{fetch(:dockerfile)} ."
      ## push the image to registry
      execute :docker, "push #{fetch(:image)}"
    end
  end
end

task "docker:stack_deploy" do
  on roles(fetch(:capose_role)) do
    within release_path do
      execute :docker, "stack deploy -c docker-compose-#{fetch(:stage)}.yml --with-registry-auth #{fetch(:application)}-#{fetch(:stage)}"
    end
  end
end
