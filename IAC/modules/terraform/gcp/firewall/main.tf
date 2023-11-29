resource "google_compute_firewall" "allow_ingress" {
  for_each = { for rule in local.firewall_rules : rule.name => rule }

  name    = each.value.name
  network = each.value.network

  allow {
    protocol = each.value.allow[0].protocol
    ports    = each.value.allow[0].ports
  }

  source_ranges = each.value.source_ranges
}
