FROM quay.io/netguru/ng-ruby:bb-2.3-onbuild

ENV RAILS_ENV staging
ENV PUMA_WORKERS 2

RUN gem install puma

## Build react_bundle package
RUN yarn
RUN npm run build
RUN rm -rf node_modules

## Root-lvl tasks
USER root

RUN echo 'Europe/Warsaw' > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Back to our user
USER rails

## Link configuration files with env variables
RUN ln -s /app/config/database.yml.env /app/config/database.yml
RUN ln -s /app/config/secrets.yml.env /app/config/secrets.yml
