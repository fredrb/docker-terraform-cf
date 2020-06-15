FROM hashicorp/terraform

ENV TERRAFORM_VERSION=0.12

WORKDIR /app

RUN wget https://github.com/cloudfoundry-community/terraform-provider-cf/releases/download/v0.12.0/terraform-provider-cloudfoundry_linux_amd64
RUN mkdir -p $HOME/.terraform.d/plugins/linux_amd64
RUN mv ./terraform-provider-cloudfoundry_linux_amd64 $HOME/.terraform.d/plugins/linux_amd64/terraform-provider-cloudfoundry
RUN chmod u+x $HOME/.terraform.d/plugins/linux_amd64/terraform-provider-cloudfoundry

ENTRYPOINT [ "/bin/sh" ]

