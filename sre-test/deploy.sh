#!/bin/bash

set -e
ARG=$1

if [ "$ARG" = "create" ]
then
    export TF_IN_AUTOMATION=true
    echo "Deploying Terraform Infrastructure"
    cd terraform && terraform init
    terraform apply -auto-approve

    # Assign variables based on TF output
    repo_url=$(terraform output ecr_repo_url)
    cluster_name=$(terraform output ecs_cluster_name)
    service_name=$(terraform output ecs_service_name)
    public_url=$(terraform output load_balancer_address)

    # Build image and login to ECR
    login_cmd=$(aws ecr get-login --no-include-email)
    cd .. && docker build --rm -f "Dockerfile" -t "$repo_url" .
    eval $login_cmd
    # Push image
    docker push $repo_url

    # Trigger a new deployment of the fargat containers.
    echo "Triggering app deployment!"
    aws ecs update-service --cluster $cluster_name --service $service_name --force-new-deployment
    echo "Deployment complete!"

    # Echo important info
    echo ""
    echo "Details:"
    echo "Public URL: ${public_url}"
    echo ""
elif [ "$ARG" = "destroy" ]
then
    echo "Destroying ALL Terraform Infrastructure. This cannot be undone. You can 5 seconds to cancel (CTRL-C)!"
    sleep 5
    cd terraform && terraform destroy -auto-approve
    echo "Destroy completed."
fi