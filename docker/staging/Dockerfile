FROM ruby:2.5.1

ENV NODE_VERSION 6.x
ENV APP_HOME=/app
ENV RAILS_ENV staging
ENV PUMA_WORKERS 2

WORKDIR /app

RUN mkdir -p $APP_HOME

# Add NodeJS to sources list
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION | bash -

# Add Yarn to the sources list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

# Install dependencies
RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yq dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential dumb-init nodejs yarn git

#### Set proper timezone
RUN \
  ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

## Add rest of code
ADD . $APP_HOME/

## Copy Gemfile & bundle
ADD Gemfile* $APP_HOME/
RUN bundle install --jobs=8 --retry=3 --without development test --deployment

RUN gem install puma

## Build react_bundle package
RUN yarn
RUN npm run build
RUN rm -rf node_modules

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Link configuration files with env variables
RUN ln -s /app/config/database.yml.env /app/config/database.yml
