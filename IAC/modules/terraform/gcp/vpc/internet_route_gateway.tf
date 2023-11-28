# 创建互联网网关(路由器)
resource "google_compute_router" "internet_router" {
  name    = "internet-router"
  network = google_compute_network.default.name
}

# 添加路由规则将流量定向到Internet网关
resource "google_compute_route" "internet_route" {
  name                  = "internet-route"
  network               = google_compute_network.default.name
  dest_range            = "0.0.0.0/0"
  next_hop_gateway      = google_compute_router.internet_router.id
}

# 创建路由器接口，连接到 Internet
resource "google_compute_router_interface" "internet_interface" {
  name    = "internet-interface"
  router  = google_compute_router.internet_router.name

}
