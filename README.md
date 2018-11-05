Setting a new Diamond ADM instance
===

Create a client identifier
---
We'll use this identifier throughout the rest of this guide. It should not contain spaces, and it should be lower case. It should be a unique identifier for the enterprise to identify the new client by. We'll call this CLIENT_CODE going forward.

Create a new github repo for the new client's codebase
---
Fork github.com/singularitySolutionsGroup/conduit naming it CLIENT_CODE. We're forking (or just copying conduit and then creating an upstream remote pointing at the conduit repo) so that any code changes that need to be applied to all clients can be made in the coduit repo and then pulled from upstream by each client.

Create the necessary 3rd party sub accounts and take note of their respective api keys
---
Be sure to configure the S3 bucket on the account on the filepicker configuration

* twilio.com
  * Add a web-hook to the new Twilio Phone Number
  * Adding the Twilio account SID and Token to the Dockerfile in infrastructure will allow the new ADM to send chat messages as outbound texts to users. Functionality has been added to allow users to reply to the text, which then shows up on the chat window in ADM. Additional configurations in Twilio are required for this to work. Switch to the subaccount of the new school on Twilio. Click on ‘Phone Numbers.’ Click directly on the new phone number to bring up an edit page. Under ‘Messaging’ add a ‘message comes in’ webhook to https://your-new-school.diamondadm.com/twilio/receive as ‘HTTP GET’
* filepicker.io
* pusher.com
* mandrillapp.com
* getsentry.com
* Google Analtyics

Create two docker repositories at quay.io
* Name them conduit-CLIENT_CODE and conduit-CLIENT_CODE-deployment
* Configure the conduit-CLIENT_CODE repository to automatically build when the github repository receives a push to the production branch. The conduit-CLIENT_CODE-deployment docker repository shouldn't be associated with a github repository. See the infrastructure documentation at github.com/singularitySolutionsGroup/infrastructure regarding how the deployment process works. 
* Create an event for conduit-CLIENT_CODE-deployment. Select that repository, click on the settings cog and you will see an option on that page to create a new event. The event is a Push to Repository, the notification is a Webhook POST, the url is https://jkqrrlp9zg.execute-api.us-east-1.amazonaws.com/production?api_key=308a4aecbe3aZ&project_id=client_code. Replace the end of the url 'client_code' with the name of the school, all undercase.
* In the conduit-CLIENT_CODE, navigate to the settings section and add three events/notifications targeting the slack channel notifications. The web hook url is (https://hooks.slack.com/services/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). Create one for build starting, a successful completion, and a failed build. You do not need to add the refs on this as it will only happen when the build has started, completed, or failed.

Create the necessary AWS components
---
1) Create a new IAM user and permissions in AWS. Use the conduit_pti user as a template to attach an inline security policy to the new user. The new user should not be given console access. Where a security group is required the `production1` security group should be used for the production environment. Use the CLIENT_CODE for naming components.
2) Create a redis database
3) Create (or re-use an existing) RDS database
4) Create an Elastic Load Balancing - ELB
5) Create an S3 bucket called `conduit_CLIENT_CODE_pdfs`
6) Create an S3 bucket called `conduit_CLIENT_CODE_packaging`
7) Create an S3 bucket called `conduit_CLIENT_CODE_file_exchange`
8) Create an S3 bucket called `conduit_CLIENT_CODE_user_content`

Create the necessary infrastructure code
---
In the github.com/singularitySolutionsGroup/infrastructure repo, make a copy of the demo folder naming it CLIENT_CODE (the unique identifier that you've established for this new client). Make sure to commit and push these changes up to github, so that the quay.io/ssgadmin/infrastructure docker image will be rebuilt with your changes included.

Setup environment variables
---
1) In the `production` folder of the newly copied folder, adjust all of the values in the Dockerfile to reflect the API keys etc. that were created above. The values for POXA_* should be set using the values issued by pusher.com above.

2) The following environment variables should be set to new random values:
* PDF_SUBMISSION_AUTHENTICATION_TOKEN
* DEVISE_SECRET_KEY

Configure the ELB
---
Take a look at the other load balancers in the account to get a sense for how the web server processes for all clients are staggered across ports. Each new client will need to be assigned a port for the web service container port 80 to be bound to and another port for the web service container port 443 to be bound to. Pick some ports for this client to use. There is a google document in the ferris@singularitysolutionsgroup.com account that I've used to track the ports that are in use.
1) Create an SSL certificate using AWS Certificate Manager
2) Update the `production1` security group to allow inbound traffic for the two new ports. 
3) Configure the ELB to use the SSL certificate you created in step 1.

Configure ECS
---
* Create the Services
  * Create a new service for the web server process. You can use the `conduit_pti_production_passenger` service as a template. Associate the ELB for this client with this ECS service.
  * Create a new service for the sidekiq process. You can use the `conduit_pti_production_sidekiq` service as a template.
  * Create a new service for the sidekiq pdf'ing process. You can use the `conduit_pti_production_sidekiq_pdf` service as a template.

* Create three task definitions in Amazon’s EC2 Container Services.
  * Passenger
  * Sidekiq
  * Sidekiq PDF

A menu on the left side lists Clusters, Task Definitions, and Repositories. Choose ‘Task Definitions’ and then click on ‘Create new Task Definition.’

Follow the general naming convention of the other tasks already in place. You will create a task for the passenger, sidekiq, and sidekiq pdf processes. Model your new tasks after the task configurations for conduit-az-culinary. Use the new port mappings you chose earlier for the configuration of the new passenger task.

Bootstrap the running system
---
At this point the system should be up and running, but no one can log into it because there are no users. There are also some initialization that needs to happen: 

1) Open a rails console and run the following to create a new user and perform the necessary initialization:
`SystemBootstrap.basic_setup`

2) Then run `SystemBootstrap.create_root_user 'YOUR FIRST NAME', 'YOUR LAST NAME', 'YOUR EMAIL'`

The system should now be fully functional. 



Local Development
===

First time setup
---
To setup your local environment to run the system, you need to run the setup script and create a root user to login with.
1) Run `./setup_for_local_development.sh` to create a new database and prepare the system for creating the root user
2) Create the root user: docker-compose run web rails runner "SystemBootstrap.create_root_user 'YOUR FIRST NAME', 'YOUR LAST NAME', 'YOUR EMAIL'"

Wipe your local environment and start over
---
If want to destroy your database and start from scratch: 
1) Shut down the system: `docker-compose down`
2) Delete the postgres storage folder: `rm -rf tmp/db`
3) Follow the first time setup instructions above

