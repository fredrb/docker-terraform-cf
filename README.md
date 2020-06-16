# Terraform + Cloud Foundry Provider Docker Image

Pre-made environment for deploying infrastructure with Terraform using [Cloud Foundry Provider](https://github.com/cloudfoundry-community/terraform-provider-cf). Made to run in CI/CD environments. 

**Keep in mind that this has to run on a clean infrastructure folder (i.e. without `.terraform` folder)**

## Usage

```bash
docker run -it --volume="/path/to/app/infrastructure:/app" fredrb/terraform-cf:latest
```

This command will fire a `/bin/sh` session on workdir with Terraform and Cloud Foundry provider available.

**Default workdir:** `/app`

### Piper

In case you're using [piper](https://github.com/SAP/jenkins-library/) in your pipeline, you can invoke this image using `dockerExecute` step follows:
```groovy
dockerExecute(
script: this,
dockerImage: 'fredrb/terraform-cf:latest',
dockerEnvVars: [
    'AWS_ACCESS_KEY_ID': '$AWS_ACCESS_KEY_ID',
    'AWS_SECRET_ACCESS_KEY': '$AWS_SECRET_ACCESS_KEY',
    'TF_VAR_some_var_to_tf': '$value'
],
dockerVolumeBind: [
    "$PWD:/app"
]
) {
    sh '''
        terraform init
        terraform apply -auto-approve -no-color -input=false
    '''
}
```

### Credentials and variables

Information can be passed to Terraform via environment variables. Just like runnning locally.

Example: 
```
docker run -it --volume="$PWD:/app" -e AWS_ACCESS_KEY_ID=<...> -e AWS_SECRET_ACCESS_KEY=<...> -e TF_VAR_some_var="<...>" fredrb/terraform-cf:latest
```