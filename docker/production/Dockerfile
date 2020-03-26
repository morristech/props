FROM ruby:2.5.7-alpine3.11

ENV APP_HOME /var/www/app
ENV NODE_REPOSITORY_URL http://dl-cdn.alpinelinux.org/alpine/v3.6/main/
ENV NODE_VERSION 6.10.3-r2
ENV TZ Europe/Warsaw
ENV RAILS_ENV production
ENV REDIS_URL redis://redis:6379/0

WORKDIR $APP_HOME

RUN apk update && apk add bash && apk add curl-dev && apk add pcre-dev
RUN apk add ca-certificates wget && update-ca-certificates

RUN mkdir -p $APP_HOME

### TODO: change passenger to puma
### Passenger
#RUN /opt/passenger/install

### Install required tools
RUN apk add --no-cache build-base dumb-init git postgresql-client postgresql-dev tzdata

### Install Nodejs, NPM and Yarn
RUN apk add  --no-cache --repository $NODE_REPOSITORY_URL nodejs=$NODE_VERSION npm yarn

### throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

#### Copy Gemfile & bundle
ADD Gemfile* $APP_HOME/
RUN bundle install --jobs=8 --retry=3 --without development test --deployment

### Add the rest of code
ADD . $APP_HOME/
ADD docker/production/entrypoint.sh /entrypoint.sh
ADD docker/production/service/sidekiq /etc/service/sidekiq/run
RUN bundle exec passenger-config compile-nginx-engine

### Build react_bundle package
RUN yarn
RUN npm run build
RUN rm -rf node_modules

### Set cron tasks
RUN bundle exec whenever --update-crontab --set environment=production

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
# CMD ["/sbin/my_init"]
# CMD bundle exec passenger start --auto
### Cleanup
RUN rm -rf /tmp/* /var/tmp/*
