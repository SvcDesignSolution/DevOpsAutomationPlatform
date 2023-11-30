resource "google_compute_project_metadata" "ssh_metadata" {
  metadata = {
    ssh-keys = local.ssh_keys_content
  }
}
