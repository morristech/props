#!/usr/bin/env ruby


CONTAINER_NAME = 'propsapp_web_1'
# replace it with your docker app port
APP_PORT = 3000

container_ip = `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "#{CONTAINER_NAME}"`.strip
sleep(15)
container_status = `curl -I "#{container_ip}:#{APP_PORT}/healthcheck/" |head -n 1|cut -d$' ' -f2`.strip.to_i

if container_status.between?(200, 299)
  p "Service is working and listening on #{APP_PORT} port"
  exit 0
end

abort("Container status: #{container_status}")
