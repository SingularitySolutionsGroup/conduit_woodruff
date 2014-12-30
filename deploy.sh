#!/bin/bash -eu
bundle install
rvmsudo god stop conduit-sidekiq
rvmsudo god stop conduit-sidekiq-pdf_production
rvmsudo passenger stop --port 80
rvmsudo passenger start --daemonize --user bitnami --ssl --ssl-certificate /home/bitnami/ssl/bryan/combined.crt --ssl-certificate-key /home/bitnami/ssl/bryan/portal.bryanu.edu.key --port 80 --ssl-port 443
sudo chmod 777 log/development.log
rvmsudo god load conduit.god
rvmsudo god start conduit-sidekiq-pdf_production
rvmsudo god start conduit-sidekiq
