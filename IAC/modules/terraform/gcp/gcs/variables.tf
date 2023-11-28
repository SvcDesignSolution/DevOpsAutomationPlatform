locals {
  config = yamldecode(file("config.yaml"))
}

variable "gcp_credentials" {
  type = string
}
