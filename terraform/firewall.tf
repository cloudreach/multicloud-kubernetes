resource "google_compute_firewall" "default" {
  name    = "mc-k8s-ssh"
  network = "${google_compute_network.default.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "master" {
  name        = "mc-k8s-master"
  network     = "${google_compute_network.default.name}"
  target_tags = ["master"]

  allow {
    protocol = "tcp"
    # https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports
    # ports    = ["6443", "2379-2380", "10250", "10251", "10252"]
    # TODO: split by source
    ports    = ["6443", "2379-2380", "10250"]
  }
}

resource "google_compute_firewall" "workers" {
  name        = "mc-k8s-workers"
  network     = "${google_compute_network.default.name}"
  target_tags = ["worker"]

  allow {
    protocol = "tcp"
    # https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports
    # TODO: split by source
    ports    = ["10250", "30000-32767"]
  }
}
