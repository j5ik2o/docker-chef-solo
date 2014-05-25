FROM ubuntu:12.10

ENV CHEF_BIN /opt/chef/embedded/bin
ENV CHEF_REPO /chef-repo

ADD chef-repo /chef-repo

RUN apt-get -y update

RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git

RUN curl -L http://www.opscode.com/chef/install.sh | bash

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

RUN ${CHEF_BIN}/gem install berkshelf

RUN cd ${CHECK_REPO} && ${CHEF_BIN}/berks vendor ${CHEF_REPO}/cookbooks

RUN cd ${CHEF_REPO} && chef-solo -c ${CHEF_REPO}/solo.rb -j ${CHEF_REPO}/nodes/docker.json
