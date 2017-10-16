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
1) twilio.com
2) filepicker.io
  * Be sure to configure the S3 bucket on the account as well
3) pusher.com
4) mandrillapp.com
5) getsentry.com
6) Google Analtyics

Create two docker repositories at quay.io
1) Name them conduit-CLIENT_CODE and conduit-CLIENT_CODE-deployment
2) Configure the conduit-CLIENT_CODE repository to automatically build when the github repository receives a push to the production branch. The conduit-CLIENT_CODE-deployment docker repository shouldn't be associated with a github repository. See the infrastructure documentation at github.com/singularitySolutionsGroup/infrastructure regarding how the deployment process works.
3) Create an event for conduit-CLIENT_CODE-deployment. Select that repository, click on the settings cog and you will see an option on that page to create a new event. The event is a Push to Repository, the notification is a Webhook POST, the url is https://jkqrrlp9zg.execute-api.us-east-1.amazonaws.com/production?api_key=308a4aecbe3aZ&project_id=client_code. Replace the end of the url 'client_code' with the name of the school, all undercase.

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
1) Create a new service for the web server process. You can use the `conduit_pti_production_passenger` service as a template. Associate the ELB for this client with this ECS service.
2) Create a new service for the sidekiq process. You can use the `conduit_pti_production_sidekiq` service as a template.
3) Create a new service for the sidekiq pdf'ing process. You can use the `conduit_pti_production_sidekiq_pdf` service as a template.

Bootstrap the running system
---
At this point the system should be up and running, but no one can log into it because there are no users. There are also some initialization that needs to happen: 

1) Open a rails console and run the following to create a new user and perform the necessary initialization:
`SystemBootstrap.basic_setup`

2) Then run `SystemBootstrap.create_root_user 'YOUR FIRST NAME', 'YOUR LAST NAME', 'YOUR EMAIL'`

The system should now be fully functional. 

