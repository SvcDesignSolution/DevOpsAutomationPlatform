# Output network information
output "network_info" {
  description = "Information about the created network"
  value = {
    network_name        = google_compute_network.default.name
    public_subnet_cidr  = google_compute_subnetwork.public_subnet.ip_cidr_range
    private_subnet1_cidr = google_compute_subnetwork.private_subnet-1.ip_cidr_range
    private_subnet2_cidr = google_compute_subnetwork.private_subnet-2.ip_cidr_range
    # Add more information as needed
  }
}
