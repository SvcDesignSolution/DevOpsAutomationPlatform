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
  name             = "default-router"
  network          = google_compute_network.default.name
  region           = local.config.region
}

# Create a default route and NAT for internet access
resource "google_compute_router_nat" "default_nat" {
  name             = "default-nat"
  router           = google_compute_router.default.name
  region           = local.config.region
  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = false
    filter = "ERRORS_ONLY"  # Specify the appropriate log filter here
  }

  subnetwork {
    name          = google_compute_network.default.self_link
    source_ip_ranges_to_nat = ["0.0.0.0/0"]
  }
}

resource "google_compute_router_interface" "web-subnet-interface" {
  name       = "web-subnet-interface"
  region     = local.config.region
  router     = google_compute_router.default.name
  subnetwork = google_compute_subnetwork.subnet_web.self_link
}

resource "google_compute_router_interface" "db-subnet-interface" {
  name       = "db-subnet-interface"
  region     = local.config.region
  subnetwork = google_compute_subnetwork.subnet_db.self_link
  router     = google_compute_router.default.name
}
