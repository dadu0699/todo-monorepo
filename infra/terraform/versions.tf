terraform {
  # Minimum Terraform version required for this project
  required_version = ">= 1.6"

  required_providers {
    google = {
      source = "hashicorp/google"
      # Google provider version pinned to avoid breaking changes
      version = ">= 6.8.0"
    }
  }
}
