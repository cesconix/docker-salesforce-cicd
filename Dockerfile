FROM alpine

LABEL maintainer Francesco Pasqua <cesconix@me.com>

# install system dependencies
RUN apk --update --no-cache add \
  libc6-compat \
  openssh \
  git \
  nodejs \
  nodejs-npm

# install nodejs dependencies
RUN npm config set user 0
RUN npm config set unsafe-perm true
RUN npm i -g \
  @semantic-release/commit-analyzer \
  @semantic-release/release-notes-generator \ 
  @semantic-release/changelog \
  @semantic-release/git \
  @semantic-release/gitlab \
  @semantic-release/exec \
  semantic-release \
  salesforce-deploy-cli \
  bump-prerelease-version \
  jfrog-cli-go

# add ssh private key
ARG SSH_PRIVATE_KEY
RUN mkdir ~/.ssh
RUN chmod 700 ~/.ssh
RUN echo "${SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
RUN chmod 600 ~/.ssh/id_rsa

# add ssh known hosts
ARG SSH_KNOWN_HOSTS
RUN echo "${SSH_KNOWN_HOSTS}" > ~/.ssh/known_hosts
RUN chmod 644 ~/.ssh/known_hosts