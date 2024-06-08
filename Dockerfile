ARG RUBY_VERSION=3.3.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential default-libmysqlclient-dev git libvips pkg-config

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl default-mysql-client libvips && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

COPY wait-for-it.sh /app/
COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod +x /app/wait-for-it.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["sh", "-c", "./wait-for-it.sh db:3306 -- ./wait-for-it.sh redis:6379 -- ./wait-for-it.sh elasticsearch:9200 -- bundle exec rails db:migrate && bundle exec rails s -b '0.0.0.0'"]
