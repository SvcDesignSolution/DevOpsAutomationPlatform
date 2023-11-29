output "instance_info" {
  value = [
    for i in range(length(local.config.instances)) : {
      hostname = google_compute_instance.example_instances[i].name
      ip       = google_compute_address.example_instances_ip[i].address
    }
  ]
}
