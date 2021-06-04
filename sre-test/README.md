# SRE Tech Task

In the final stage of our interview process we want to discover how you approach SRE day-to-day. In preparation for the interview we request you complete the following task.

This is a coding exercise to help us assess candidates looking to join the Cloud Platform SRE team at Condé Nast. It is not a pass or fail, but it will be used as the basis for questions and discussion in the interview.
We appreciate that your time is valuable, which is why we’ve designed this exercise to be completed in around 1-2 hours. If you cannot spare the time, you may want to consider option 2.

## Option 1
This codebase contains a simple 'Hello World' node.js web application running in AWS Fargate, and the infrastructure within which it is deployed.

The test is to introduce observability to this application and its infrastructure using terraform and available AWS tools. The goal is to come up with a solution that is repeatable and can be easily reasoned about.

We're not looking for a production ready solution, and wouldn't expect you to spend more than 2 hours on the task.

It's important to note that we will be asking you questions about your solution in the face-to-face interview, and you will be expected to provide justification for your design decision.

Some things to consider when designing your solution:

- Consider how well your solution be applied to other applications and infrastructure?
- Think about proactive vs reactive monitoring, and what the advantages might be of each.
- How well does it scale? How will it react to adding additional instances of our application, or additional supporting services?
- Documentation is important to us. We have keen eye on how you present the information and how can it be used.
- We want to see what you can achieve within the time that you have: how you approach the task and how you deal with the complexity of the solution. Again, we aren't looking for a production ready solution.

### Codebase Requirements

1. AWS CLI installed and configured with **default** profile, **including access key and secret** - See [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) for details.
2. Your IAM user account will need sufficient access to create the infrstructure. Granting `Administrator` access is easiest, but production environments should generally follow principle of least privilege.
3. [Terraform](https://terraform.io). *Note: The deployment script will assume the `terraform` binary is in your `$PATH`*.
4. Docker CE installed and running.

### Setup and Run

- Configure your AWS CLI default profile, along with `Access Key` and `Access Secret`: Instructions can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).
- Ensure `terraform` is in your `$PATH`. [Windows](https://www.howtogeek.com/118594/how-to-edit-your-system-path-for-easy-command-line-access/) | [Linux](https://www.techrepublic.com/article/how-to-add-directories-to-your-path-in-linux/)
- Execute the deployment script:
  - `deploy.sh create` - Deploy or update the application. Terraform is idempotent, so it will only update resources as required. Docker also caches layers, so will only push a new image if there are changes. A new deployment of the container in ECS is forced as part of the script. **Note**: The service can take 1-2 minutes to start on the first deploy!
  - `deploy.sh destroy` - Kill the application and all related infrastructure. **WARNING:** This **WILL** destroy all the infrastructure managed by terraform with *extreme prejudice*. There is no confirmation and cancelling after the 5 second window will likely leave your infrastructure in an incomplete state.

## Option 2
If you have some personal code that you would be prepared to share with us, we can assess that instead. The code should meet the following criteria:

- It should be your own work.
- It should cover the points that we are looking for in option 1
- It should demonstrate how you approach any particular problem
- It should be something that you are able to discuss with us


##  Submission
You can submit your code however you want - send the details to your point of contact. Please include a README containing any relevant information.
