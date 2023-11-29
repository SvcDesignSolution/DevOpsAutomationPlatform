# 创建路由器
resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = google_compute_network.default.name
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "nat_gateway"
  router                             = google_compute_router.nat_router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# 添加路由规则将流量定向到 NAT
resource "google_compute_route" "nat_route" {
  name                  = "nat-route"
  network               = google_compute_network.default.name
  dest_range            = "0.0.0.0/0"
  next_hop_router       = google_compute_router.nat_router.name
}

# 创建路由器接口，将子网连接到路由器
resource "google_compute_router_interface" "nat_router_interface" {
  name    = "nat-router-interface"
  router  = google_compute_router.nat_router.name
}

