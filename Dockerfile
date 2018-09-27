FROM ruby:2.5.1

RUN apt-get update && apt-get install -y postgresql-client nodejs build-essential

WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .

ENTRYPOINT ["bin/docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
