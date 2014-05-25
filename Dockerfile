FROM ubuntu:12.10

ENV CHEFHOME /chef-repo
ADD chef-repo /chef-repo

RUN apt-get -y update

RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git

RUN curl -L http://www.opscode.com/chef/install.sh | bash

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

RUN /opt/chef/embedded/bin/gem install berkshelf

RUN cd /chef-repo && /opt/chef/embedded/bin/berks vendor /chef-repo/cookbooks

RUN cd ${CHEFHOME} && chef-solo -c ${CHEFHOME}/solo.rb -j ${CHEFHOME}/nodes/docker.json
