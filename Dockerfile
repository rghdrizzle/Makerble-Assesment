FROM ruby:3.1.2-alpine
WORKDIR /app
RUN apk add --update build-base bash bash-completion libffi-dev tzdata postgresql-client postgresql-dev nodejs npm yarn

RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install 
COPY package.json package-lock.json ./

COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
