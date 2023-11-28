output "vpc_name" {
  value = google_compute_network.default.name
}

output "subnet_web_cidr" {
  value = google_compute_subnetwork.subnet_web.ip_cidr_range
}

output "subnet_db_cidr" {
  value = google_compute_subnetwork.subnet_db.ip_cidr_range
}

output "router_name" {
  value = google_compute_router.default.name
}
