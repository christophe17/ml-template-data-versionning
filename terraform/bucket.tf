resource "google_storage_bucket" "mltpl_data_versionning_bucket" {
  name          = "mltpl-data-versionning-bucket"
  location      = var.gcp_region
  storage_class = "STANDARD"
  force_destroy = true

  versioning {
    enabled = false
  }
}
