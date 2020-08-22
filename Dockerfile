FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

ARG APP_NAME

RUN mkdir /workspace
WORKDIR /workspace

RUN gem install rails -v 6.0.3.2 

# Create .railsrc config file by pulling it down from Github gist
RUN curl https://gist.githubusercontent.com/fdel15/eda9cc219f7ea200a8bb8c16881e0c24/raw/1e420e516938c12eeb06705ffc317f83bb88074e/railsrc > .railsrc


# RUN rails new $APP_NAME
# -T means do not use TestUnit framework
# RUN rails new $APP_NAME -d=postgresql --webpack=react -T --template=
