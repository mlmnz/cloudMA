provider "google" {
  credentials = file(var.gcp_credentials)
  project = var.project_name
  region  = var.region_name
  zone    = var.zone_name
}
