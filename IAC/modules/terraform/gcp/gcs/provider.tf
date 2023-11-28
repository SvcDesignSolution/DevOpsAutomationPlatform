provider "google" {
  credentials = var.gcp_credentials
  project     = local.config.project_id
  region      = local.config.region
}
