terraform {
  required_version = ">= 1.9"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.42.0"
    }
  }
  backend "gcs" {
    bucket = "mltpl-terraform"
    prefix = "data-versionning"
  }
}


provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}