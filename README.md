# Configure OpenID Connect (OIDC) between GCP and GitLab

This repo contains a sample Terraform module to automate the GCP workload identity creation required for gitlab (can be used for other providers as well).

For additional details, see the below documentations 

https://cloud.google.com/iam/docs/configuring-workload-identity-federation#oidc
https://docs.gitlab.com/ee/ci/cloud_services/google_cloud/

Terraform code is available under `terraform/` and refer to the `.gitlab-ci.yml` sample gitlab pipeline using this setup.
