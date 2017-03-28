FROM quay.io/ssgadmin/conduit_base:master
ADD ./ /home/app/webapp
RUN bundle install
