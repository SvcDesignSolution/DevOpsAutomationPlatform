data "local_file" "ssh_key" {
  filename = local.ssh_key_path
}

resource "google_compute_project_metadata" "default" {
  metadata = {
    "ssh-keys" = <<EOF
        "ubuntu:${data.local_file.ssh_key.content}"
    EOF
  }
}
