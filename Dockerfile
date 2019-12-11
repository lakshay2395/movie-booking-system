FROM jruby:9.2.6.0
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler:2.0.2
RUN gem update bundler
RUN bundle install
RUN JRUBY_OPTS="--debug" bundle exec rspec
ADD . /myapp
EXPOSE 8080
ENTRYPOINT ["rails", "s" , "-p" , "8080", "-b" , "0.0.0.0"]