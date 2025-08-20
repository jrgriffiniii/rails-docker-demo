# Dockerfile for a Ruby on Rails application

# ==> Base Stage
# Sets up the base image with necessary dependencies for both building and running the app.
# Using a specific Ruby version is recommended for consistency.
ARG RUBY_VERSION=3.4-trixie
FROM ruby:${RUBY_VERSION}

# Install essential packages
# - build-essential: For compiling native extensions for gems.
# - libpq-dev: For the 'pg' gem to connect to PostgreSQL.
# - nodejs & yarn: For JavaScript asset management (if using webpacker/sprockets).
# - curl, gnupg, apt-transport-https: For adding repositories.
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev curl gnupg apt-transport-https

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs

# Set the working directory inside the container
WORKDIR /rails

# Install bundler
RUN gem install bundler

# Copy the Rails application
COPY hello_world ./

# Install gems
# Using --jobs 4 can speed up the process.
RUN bundle install --jobs 4 --retry 3

# Precompile assets
# This compiles CSS and JavaScript, so it doesn't have to be done on the fly in production.
# SECRET_KEY_BASE is set to a dummy value because it's required for asset compilation.
RUN SECRET_KEY_BASE=dummy DATABASE_HOST=dummy DATABASE_USER=dummy DATABASE_PASSWORD=secret DATABASE_NAME=default bundle exec rails assets:precompile

# Expose port 3000 to the host machine
EXPOSE 3000

# The command to run when the container starts
# This will start the Puma web server.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

