FROM quay.io/ssgadmin/conduit_base:master
ENV BUNDLE_GITHUB__COM=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:x-oauth-basic
RUN mkdir /home/app/phantomjs-2.1.1-linux-x86_64
COPY ./phantomjs-2.1.1-linux-x86_64 /home/app/phantomjs-2.1.1-linux-x86_64/.
RUN ls /home/app/
RUN ln -sf /home/app/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
ADD ./ /home/app/webapp
RUN bundle install
