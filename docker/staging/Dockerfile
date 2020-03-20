FROM ruby:2.5.7-alpine3.11

ENV APP_HOME=/app
ENV NODE_REPOSITORY_URL http://dl-cdn.alpinelinux.org/alpine/v3.6/main/
ENV NODE_VERSION 6.10.3-r2
ENV TZ Europe/Warsaw
ENV RAILS_ENV staging
ENV PUMA_WORKERS 2

RUN apk update && apk add bash

WORKDIR $APP_HOME

RUN mkdir -p $APP_HOME

### Install required tools
RUN apk add --no-cache build-base dumb-init git postgresql-client postgresql-dev tzdata

### Install Nodejs, NPM and Yarn
RUN apk add  --no-cache --repository $NODE_REPOSITORY_URL nodejs=$NODE_VERSION npm yarn

### Copy Gemfile & bundle
ADD Gemfile* $APP_HOME/
RUN bundle install --jobs=8 --retry=3 --without development test --deployment

RUN gem install puma

### Add the rest of code
ADD . $APP_HOME/

## Build react_bundle package
RUN yarn
RUN npm run build
RUN rm -rf node_modules

### Cleanup
RUN rm -rf /tmp/* /var/tmp/*

### Link configuration files with env variables
RUN ln -s /app/config/database.yml.env /app/config/database.yml
