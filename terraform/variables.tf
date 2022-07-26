variable "gitlab_url" {
  type    = string
  default = "https://gitlab.com"
}

variable "gitlab_namespace_path" {
  type        = string
  description = "Namespace Path to Filter Auth Requests. In GitLab, a namespace is a unique name for a user, a group, or subgroup under which a project can be created."
  default = "xxxxx"
}

variable "gcp_project_name" {
  type        = string
  description = "GCP project to create and configure workoad identity federation"
  default = "sandbox"
}