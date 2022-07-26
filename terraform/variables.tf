variable "gitlab_url" {
  description = "Gitlab URL"
  type        = string
  default     = "https://gitlab.com"
}

variable "gitlab_namespace_path" {
  description = "Namespace Path to Filter Auth Requests. In GitLab, a namespace is a unique name for a user, a group, or subgroup under which a project can be created."
  type        = string
  default     = "xxxxx"
}

variable "gcp_project_name" {
  description = "GCP project to create and configure workoad identity federation"
  type        = string
  default     = "rightmove-sandbox"
}