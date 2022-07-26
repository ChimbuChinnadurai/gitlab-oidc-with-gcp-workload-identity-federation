# Configure OpenID Connect (OIDC) between GCP and GitLab
A Terraform module to automates the GCP workload identity creation described [here](https://docs.gitlab.com/ee/ci/cloud_services/google_cloud/).

## Use-cases
* Retrieve temporary credentials from GCP to access cloud services
* Use credentials to retrieve secrets or deploy to an environment
* Scope role to group or subgroup or branch or project

For additional details, see the below documentations 
https://cloud.google.com/iam/docs/configuring-workload-identity-federation#oidc
https://docs.gitlab.com/ee/ci/cloud_services/google_cloud/

## Steps
1. Apply this module
```
module "gitlab-gcp-oidc" {
  source = "git::git@gitlab.com:guided-explorations/gcp/configure-openid-connect-in-gcp.git//?ref=main"

  gitlab_url            = "https://gitlab.com"
  gitlab_project_id     = "123"
  gitlab_namespace_path = "my/repo"
  gcp_project_name      = "my-gcp-project"
}
```

2. Copy the `run_gcp_sts.sh` file to the Gitlab repository that you want to gain GCP access for.  This script is used to get
the GCP `access_token`.

3. Create your Gitlab CI/CD pipeline by creating a file called: `.gitlab-ci.yml` with the following content:

```yaml
variables:
  # The outputs from the terraform module:
  GCP_WORKLOAD_IDENTITY_PROVIDER: <GCP_WORKLOAD_IDENTITY_PROVIDER>
  PROJECT_NUMBER: "PROJECT_NUMBER"
  POOL_ID: gitlab-pool-xxxxxx
  PROVIDER_ID: gitlab-jwt-xxxxx
  SERVICE_ACCOUNT_EMAIL: gitlab-runner-service-account@<project ID>.iam.gserviceaccount.com

stages:
  - get_gcp_keys
  - build

gcp-auth:
  stage: get_gcp_keys
  image: google/cloud-sdk:slim
  script:
    - echo ${CI_JOB_JWT_V2} > .ci_job_jwt_file
    - echo "GCP_WORKLOAD_IDENTITY_PROVIDER -  ${GCP_WORKLOAD_IDENTITY_PROVIDER}"
    - gcloud iam workload-identity-pools create-cred-config ${GCP_WORKLOAD_IDENTITY_PROVIDER}
      --service-account="${GCP_SERVICE_ACCOUNT}"
      --output-file=.gcp_temp_cred.json
      --credential-source-file=.ci_job_jwt_file
    - gcloud auth login --cred-file=`pwd`/.gcp_temp_cred.json
    - gcloud auth list

gcp-sts:
  stage: get_gcp_keys
  image: registry.gitlab.com/gitlab-org/terraform-images/stable:latest
  script:
  - CLOUDSDK_AUTH_ACCESS_TOKEN=$(./run_gcp_sts.sh)
  - echo "CLOUDSDK_AUTH_ACCESS_TOKEN=$CLOUDSDK_AUTH_ACCESS_TOKEN" >> vars.env
  # Setting this output vars into subsequent stages so that they have the CLOUDSDK_AUTH_ACCESS_TOKEN var for
  # gcloud to use.
  # Doc: https://docs.gitlab.com/ee/ci/environments/#set-dynamic-environment-urls-after-a-job-finishes
  artifacts:
    reports:
      dotenv: vars.env

key-usage:
  stage: build
  image: google/cloud-sdk:slim
  script:
    # The gcloud cli will look for the $CLOUDSDK_AUTH_ACCESS_TOKEN envar as one of the authentication
    # option and if it finds, this var, it will try to use this var for authentication.
    - echo $CLOUDSDK_AUTH_ACCESS_TOKEN
    - gcloud container clusters list --region us-central1 --project <project id>
```

This pipeline will:
* Will authenticate and get a GCP token
* Uses the access key to list the GKE clusters in the project

## Resources

- https://cloud.google.com/iam/docs/configuring-workload-identity-federation#oidc

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_iam_workload_identity_pool.gitlab-pool](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_workload_identity_pool) | resource |
| [google-beta_google_iam_workload_identity_pool_provider.gitlab-provider-jwt](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_iam_workload_identity_pool_provider) | resource |
| [google-beta_google_service_account_iam_binding.gitlab-runner-oidc](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_service_account_iam_binding) | resource |
| [google_service_account.gitlab-runner](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_id.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_project_name"></a> [gcp\_project\_name](#input\_gcp\_project\_name) | GCP project to create and configure workoad identity federation | `string` | `"sandbox"` | no |
| <a name="input_gitlab_namespace_path"></a> [gitlab\_namespace\_path](#input\_gitlab\_namespace\_path) | Namespace Path to Filter Auth Requests. In GitLab, a namespace is a unique name for a user, a group, or subgroup under which a project can be created. | `string` | `"xxxxx"` | no |
| <a name="input_gitlab_url"></a> [gitlab\_url](#input\_gitlab\_url) | n/a | `string` | `"https://gitlab.com"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_GCP_SERVICE_ACCOUNT"></a> [GCP\_SERVICE\_ACCOUNT](#output\_GCP\_SERVICE\_ACCOUNT) | n/a |
| <a name="output_GCP_WORKLOAD_IDENTITY_PROVIDER"></a> [GCP\_WORKLOAD\_IDENTITY\_PROVIDER](#output\_GCP\_WORKLOAD\_IDENTITY\_PROVIDER) | n/a |
<!-- END_TF_DOCS -->