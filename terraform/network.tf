resource "google_compute_network" "default" {
  name                    = "mc-k8s--network"
  auto_create_subnetworks = "true"
}
