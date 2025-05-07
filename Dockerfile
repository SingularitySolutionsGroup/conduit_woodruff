# FROM quay.io/ssgadmin/conduit_base:master
FROM 089140149962.dkr.ecr.us-east-1.amazonaws.com/conduit_base:latest
# FROM techdiamondsis/conduit_base:latest
ENV BUNDLE_GITHUB__COM=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:x-oauth-basic
RUN mkdir /home/app/phantomjs-2.1.1-linux-x86_64
COPY ./phantomjs-2.1.1-linux-x86_64 /home/app/phantomjs-2.1.1-linux-x86_64/.
RUN ls /home/app/
RUN ln -sf /home/app/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
ADD ./ /home/app/webapp
RUN bundle install --jobs 16
