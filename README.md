# Terraform + Cloud Foundry Provider Docker Image

Pre-made environment for deploying infrastructure with Terraform using [Cloud Foundry Provider](https://github.com/cloudfoundry-community/terraform-provider-cf). Made to run in CI/CD environments. 

**Keep in mind that this has to run on a clean infrastructure folder (i.e. without `.terraform` folder)**

## Usage

```bash
docker run -it --volume="/path/to/app/infrastructure:/app" terraform-cf:latest
```

The image will run the following commands on `/app` folder:

```bash
terraform init # initializes providers and identifies remote store
terraform apply -auto-approve -input=false
```

### Modules

If your application has multiple modules and the folder structure looks something like the following:

```
infrastructure/
    prod/
    dev/
    qa/
    modules/
```

Run the following:
```bash
docker run -it --volume="/path/to/app/infrastructure:/infrastructure" -w="/infrastructure/prod" terraform-cf:latest
```

Since the image will always execute `terraform` on `WORKDIR`, you can assign the volume to the infrastructure folder and set `WORKDIR` when running the container via `-w` parameter.


### Custom Run Script

In case you want to run specific commands against terraform, you can swap the bash file executed at `entrypoint`. 

**custom_run.sh**
```bash
#!/bin/sh
terraform init
echo "running plan"
terraform plan
```

And run:
```
docker run -it --volume="$PWD:/app" --entrypoint="/app/custom_run.sh" terraform-cf:latest
```

### Credentials, variables and variable files

Information can be passed to Terraform either via environment variables or a variable file. Just like runnning locally.
You can either use `-e VAR=VALUE` or specify the path of the var file (in the mounted volume) as `-e VAR_FILE='/path/to/tvars'`. 

Example: 
```
docker run -it --volume="$PWD/infrastructure:/infra" -w="/infra/prod" -e AWS_ACCESS_KEY_ID=<...> -e AWS_SECRET_ACCESS_KEY=<...> -e VAR_FILE="/infra/prod/terraform.tfvars" -e TF_VAR_some_var="<...>" terraform-cf:latest
```