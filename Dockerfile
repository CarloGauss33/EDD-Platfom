FROM ruby:2.7.5

WORKDIR /app
COPY package.json yarn.lock /app/
COPY Gemfile Gemfile.lock /app/
COPY Aptfile /app/
COPY .node-version .ruby-version /app/

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client

# Install Buildpack dependencies
RUN xargs -a Aptfile apt-get install -y
RUN apt-get install libvips

# Install Ruby dependencies
RUN BUNDLER_VERSION=$(cat Gemfile.lock | tail -1 | tr -d " ") && \
    gem install bundler:$BUNDLER_VERSION && \
    bundle _$(echo $BUNDLER_VERSION)_ install

# Install yarn dependencies
RUN curl -sL https://deb.nodesource.com/setup_$(cat .node-version).x | bash - && \
    apt-get install -y nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install yarn && \
    yarn install --frozen-lockfile
COPY . /app

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R 1000:1000 db log storage tmp
USER 1000:1000

# Deployment options
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true"

# Start the main process.
EXPOSE 3000
