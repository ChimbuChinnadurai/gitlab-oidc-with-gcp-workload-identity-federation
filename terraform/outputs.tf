output "GCP_WORKLOAD_IDENTITY_PROVIDER" {
  description = "GCP workload identity provider resource name"
  value       = google_iam_workload_identity_pool_provider.gitlab-provider-jwt.name
}

output "GCP_SERVICE_ACCOUNT" {
  description = "GCP service account"
  value       = google_service_account.gitlab-runner.email
}