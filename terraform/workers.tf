resource "google_compute_instance" "workers_gce" {
  name         = "mc-k8s-worker-gce"
  description  = "A Kubernetes Worker on GCE"
  tags         = ["worker"]
  # kubeadm recommends at least 2 cpu and 2 GB memory
  # n1-standard-2 has 2 cpu and 7.5 GB memory
  machine_type = "n1-standard-2"

  metadata = {
    ssh-keys = "mc-k8s:${file("../mc-k8s.pub")}"
  }

  metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y dist-upgrade"

  boot_disk {
    auto_delete = true
    initialize_params {
      # Note: Newer distros will require changes to iptables:
      #       Must use legacy mode, rather than nftables backend.
      image = "ubuntu-os-cloud/ubuntu-minimal-1804-lts"
    }
  }

  network_interface {
    network       = "${google_compute_network.default.self_link}"
    access_config {
    }
  }
}
