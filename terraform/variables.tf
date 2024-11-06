# GCP Project
variable "gcp_project" {
  description = "Project in which GCP Resources to be created"
  type        = string
  default     = "mltpl"
}

# GCP Region
variable "gcp_region" {
  description = "Region in which GCP Resources to be created"
  type        = string
  default     = "us-east1"
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "dev"
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
  default     = "sap"
}

# Service Account
variable "service_account" {
  description = "Service Account to be used for GCP Resources"
  type        = string
  default     = ""
}

# VPC Network
# variable "vpc_network" {
#   description = "The VPC network to attach Cloud NAT."
#   type        = string
# }

###########################
# Cybulde Data Processing #
###########################

variable "gitbuh_access_token" {
  description = "The value for my Github Access Token"
  type        = string
  sensitive   = true
}
