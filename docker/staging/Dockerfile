FROM ruby:2.6.6-alpine3.12

ENV APP_HOME=/app
ENV NODE_REPOSITORY_URL http://dl-cdn.alpinelinux.org/alpine/v3.6/main/
ENV NODE_VERSION 6.10.3-r2
ENV TZ Europe/Warsaw
ENV RAILS_ENV staging
ENV PUMA_WORKERS 2
ENV TEST_ECR_ENV_2 $TEST_ECR_ENV
ENV TEST_RAILS_ENV $RAILS_ENV

WORKDIR $APP_HOME

### Install required tools
### Install Nodejs, NPM and Yarn
RUN apk update && apk add bash && \
  mkdir -p $APP_HOME && \
  apk add --no-cache build-base dumb-init git postgresql-client postgresql-dev tzdata && \
  apk add  --no-cache --repository $NODE_REPOSITORY_URL nodejs=$NODE_VERSION npm yarn

### Copy Gemfile & bundle
ADD Gemfile* $APP_HOME/
RUN gem install bundler:1.17.3 && \
  bundle install --jobs=8 --retry=3 --without development test --deployment && \
  gem install puma

### Add the rest of code
ADD . $APP_HOME/

## Build react_bundle package
### Cleanup
### Link configuration files with env variables
RUN yarn && \
  npm run build && \
  rm -rf node_modules && \
  rm -rf /tmp/* /var/tmp/* && \
  ln -s /app/config/database.yml.env /app/config/database.yml
