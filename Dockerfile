FROM ruby:2.5

LABEL MAINTAINER="hoangmy92@gmail.com"

ENV LANG C.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  vim \
  nodejs

# Add SSH
COPY .ssh /tmp/.ssh
RUN mkdir ~/.ssh \
  && cat /tmp/.ssh/config >> /root/.ssh/config \
  && cat /tmp/.ssh/id_rsa.pub >> /root/.ssh/id_rsa.pub \
  && cat /tmp/.ssh/id_rsa >> /root/.ssh/id_rsa \
  && chmod 600 /root/.ssh/config \
  && chmod 644 /root/.ssh/id_rsa.pub \
  && chmod 400 /root/.ssh/id_rsa

# Install bundler
# https://github.com/rubygems/rubygems/pull/2354
RUN gem install bundler

# Install NodeJS's packages
RUN npm install -g yarn

WORKDIR /src
ADD . .

# Install Capitrano's packages
RUN bundle install
VOLUME /src

CMD ["/bin/bash"]
