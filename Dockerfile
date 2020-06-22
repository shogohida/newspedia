FROM ruby:2.6.6

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
apt-transport-https
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
nodejs \
yarn

RUN mkdir /newspedia
WORKDIR /newspedia
COPY Gemfile /newspedia/Gemfile
COPY Gemfile.lock /newspedia/Gemfile.lock
RUN gem install bundler:2.1.4

RUN bundle install
COPY . /newspedia

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
