# syntax=docker/dockerfile:1
FROM opensuse/tumbleweed
RUN zypper --non-interactive refresh
RUN zypper --non-interactive install \
  gcc \
  gcc-c++ \
  git-core \
  make \
  nodejs \
  ruby-devel

RUN useradd ruby
USER ruby
WORKDIR /home/ruby

COPY timestamp-clone .
RUN git clone https://github.com/jirislaby/claburedb-frontend
WORKDIR claburedb-frontend
COPY --chown=ruby:ruby storage/database*.db storage/svcomp*.db storage/
COPY --chown=ruby:ruby ./config/credentials.yml.enc config/

RUN bundle config set --local path 'gem_home'
RUN grep sql Gemfile
RUN bundle install
COPY timestamp-update .
RUN git pull
RUN bundle exec rake assets:precompile

EXPOSE 3000
ENTRYPOINT bundle exec rails server -e production --no-log-to-stdout
