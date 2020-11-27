FROM ruby:2.5

RUN apt-get update && gem install bundler

COPY . .

RUN bundle install
