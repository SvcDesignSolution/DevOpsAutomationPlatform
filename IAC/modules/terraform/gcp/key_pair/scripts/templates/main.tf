resource "google_compute_project_metadata" "ssh_metadata" {
  metadata = {
    {{ vars.key_pairs[0].name }} = local.ssh_keys_content
  }
}
