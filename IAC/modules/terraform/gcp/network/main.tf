# Create a VPC network
resource "google_compute_network" "default" {
  name                    = "custom"
  project                 = local.config.project_id
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
  delete_default_routes_on_create = true
  description             = "My custom network"
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "subnet-gateway"
  ip_cidr_range = "${cidrsubnet(local.config.vpc_cidr, 8, 0)}"
  region        = local.config.region
  network       = google_compute_network.default.name
}

resource "google_compute_subnetwork" "private_subnet-1" {
  name          = "subnet-app"
  ip_cidr_range = "${cidrsubnet(local.config.vpc_cidr, 8, 1)}"
  region        = local.config.region
  network        = google_compute_network.default.name
}

resource "google_compute_subnetwork" "private_subnet-2" {
  name          = "subnet-db"
  ip_cidr_range = "${cidrsubnet(local.config.vpc_cidr, 8, 2)}"
  region        = local.config.region
  network        = google_compute_network.default.name
}
