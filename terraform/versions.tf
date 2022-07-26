terraform {
  required_version = ">= 1.0.1"

  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}