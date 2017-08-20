# Node Web App

## Pre-requisites

1. Terraform
1. Docker

## Instructions

### As a developer

#### Building a Dev environment

1. Pull down the repo:

```git
git clone ....
```

1. Change to the 'container' directory and build the new container:

```docker
docker build -t sonicintrusion/node-web-app .
```

1. Run the container on your local machine:

```docker
docker run -p 49494:8080 -d sonicintrusion/node-web-app
```

1. Test the app in the browser using the link: `http://localhost:49494` OR using the curl utility:

```bash
curl http://localhost:49494
```

#### Making app updates and pushing to registry

1. Make changes to the app within the **'app'** directory.
1. Update the package.json file with the version number.
1. Build the container as before but ensure a version number is included: `docker build -t sonicintrusion/node-web-app:<version_no> .`
1. Test the app as required.
1. Login to the registry and upload the container (public registry used in this example)

```docker
docker login
docker push sonicintrusion/node-web-app:<version number>
```

_Note_: login will not be permitted unless administrator has granted access to the registry

#### Making releases available

1. Download the container with the version to be released.
1. Retag the container with the appropriate _'env'_ tag: [Int, QA, VP, Prod]

```docker
docker tag sonicintrusion/node-web-app:<version_no> sonicintrusion/node-web-app:<env>
```

1. Push the version to the registry for release:

```docker
docker push sonicintrusion/node-web-app:<env>
```

### As the Infrastructure Developer/Engineer

This requires that at least one container has been uploaded to the container registry.

1. Pull down the code repo:

```git
git clone ....
```

1. Change to the 'infrastructure/terraform' directory.
1. Check README.md and update necessary variables.
1. Use _terraform_ to build the infrastructure:

```terraform
terraform plan
terraform apply
```

**Note**: assumes you have sufficient permission in your IAM role to create additional IAM roles.