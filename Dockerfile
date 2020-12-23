FROM ruby:2.5

WORKDIR /app

RUN apt-get update && gem install bundler

COPY . .

RUN bundle install

CMD ./start.sh
