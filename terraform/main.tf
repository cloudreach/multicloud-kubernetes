provider "google" {
  credentials = "${file("../gce-sa.json")}"
  project = "cr-lab-smathys-0511195030"
  region  = "europe-west4"
  zone    = "europe-west4-b"
}
