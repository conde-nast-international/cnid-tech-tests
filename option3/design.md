# Option 3

## Design

### The app

A simple _hello world_ app written in NodeJS

### Integrations

The simple _hello world_ app will be public facing with no real backend but consideration for allowing connectivity to other services should be made -- ie routes/rules to access RDS or other database systems.

### Environments

Using config manageable code, such as Ansible, will mean all environments can be _made_ the same. However, developer environments will need to be built in Vagrant.

Using containers means the development environment is exactly like the prodution. The containers can be tested before they are released into the pipeline.

### Performance and scaling

Load balancing the application through ELB.

Consideration for scaling horizontally through ASG.

### Automation and deployment

A pipeline to control the deployment of new containers. Hand-off to orchestration tools.

Change control, review and approval can be tied in.

### Configuration Management

Docker is better integrated into ECS but using ansible-container means we can reuse the ansible code for deploying through vagrant and/or any other platform.

Dockerfile is a different style of configuration that cannot be ported to a different platform.

### Application release and testing

Consideration about testing each component [application, container, infrastrucutre].

Pipelines to test and integrate each layer.


## Solution

1. a simple nodejs hello world application
1. a packer job to build a hardened OS - from a centos base
1. an ansible playbook to build the applciation environment
1. docker-compose to test interoperability/integration testing
1. script to upload container to artefact repo
1. terraform code to stand up the infrastructure (IAM, VPC, SC, etc) - do we want to use kubernetes?
1. terraform code to configure ECS/kubernetes
1. configure ASG and container orchestration (kubernetes or swarm?)

### Questons

1. Where can I store the images? Maybe S3
1. What is the best way to install an app to a container?
1. What in/out paths are required to use the app?
1. How do you test the security of a container? Can you os harden a container?
1. What artefactory do we use? Can we use ECS?
1. what orchestration tool should we use? AWS ELB and ECS? or kubernetes?

## Achieved

1. "Hello World" app on Node.JS container
1. Container shared to Docker Hub
1. Infrastructure code to stand up ECS cluster and run container
