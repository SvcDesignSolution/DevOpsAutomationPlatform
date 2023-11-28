# Create a VPC network
resource "google_compute_network" "default" {
  name                    = "devops"
  project                 = local.config.project_id
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
  delete_default_routes_on_create = true
  description             = "My custom network"
}

# Create a subnet for web servers
resource "google_compute_subnetwork" "subnet_web" {
  name          = "web-subnet"
  ip_cidr_range = "${cidrsubnet(local.config.vpc_cidr, 8, 0)}"
  region        = local.config.region
  network        = google_compute_network.default.name
}

# Create a subnet for database servers
resource "google_compute_subnetwork" "subnet_db" {
  name          = "db-subnet"
  ip_cidr_range = "${cidrsubnet(local.config.vpc_cidr, 8, 1)}"
  region        = local.config.region
  network        = google_compute_network.default.name
}

# Create a router and a default route to the internet
resource "google_compute_router" "default" {
  name    = "default-router"
  network = google_compute_network.default.name

  router_nat {
    nat_ip_allocate_option = "MANUAL_ONLY"
  }
}

resource "google_compute_router_interface" "web-subnet-interface" {
  name        = "web-subnet-interface"
  subnetwork  = google_compute_subnetwork.subnet_web.name
  router       = google_compute_router.default.name
}

resource "google_compute_router_interface" "db-subnet-interface" {
  name        = "db-subnet-interface"
  subnetwork  = google_compute_subnetwork.subnet_db.name
  router       = google_compute_router.default.name
}
