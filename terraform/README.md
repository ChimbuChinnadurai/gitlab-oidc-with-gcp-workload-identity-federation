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