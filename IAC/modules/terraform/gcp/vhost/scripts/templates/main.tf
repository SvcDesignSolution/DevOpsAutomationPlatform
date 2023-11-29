{% for instance in vars.instances %}
resource "google_compute_address" "{{ instance.name | lower }}" {
  name    = "{{ instance.name }}"
  project = "{{ config.project_id }}"
  region  = "{{ config.region }}"
}

resource "google_compute_instance" "{{ instance.name | lower }}" {
  name         = "{{ instance.name }}"
  machine_type = "{{ instance.type }}"
  zone         = "{{ instance.zone }}"

  boot_disk {
    initialize_params {
      image = "{{ instance.image }}"
      size  = {{ instance.disk_size_gb }}
    }
  }

  network_interface {
    network = "default"  # Your network name

    access_config {
      nat_ip = google_compute_address.{{ instance.name | lower }}.address
    }
  }

  depends_on = [google_compute_address.{{ instance.name | lower }}]
}
{% endfor %}
