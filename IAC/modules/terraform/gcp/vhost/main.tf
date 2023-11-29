resource "google_compute_address" "instances_ip" {
  count   = length(local.config.instances)
  name    = "example-instance-ip-${count.index + 1}"
  project = local.config.project_id
  region  = local.config.region
}

resource "google_compute_instance" "instances" {
  count = length(local.config.instances)

  name         = local.config.instances[count.index].name
  machine_type = local.config.instances[count.index].type
  zone         = local.config.instances[count.index].zone

  boot_disk {
    initialize_params {
      image = local.config.instances[count.index].image
      size  = local.config.instances[count.index].disk_size_gb
    }
  }

  network_interface {
    network = "default"  # 你的网络名称

    access_config {
      nat_ip = google_compute_address.instances_ip[count.index].address
    }
  }

  depends_on = [google_compute_address.instances_ip[count.index]]
  }
}
