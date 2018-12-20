# Create custom nework/subnet in multiple regions
resource "google_compute_network" "dataproc-cluster-net" {
  count                   = "${length(var.network_regions)}"
  name                    = "dp-${lookup(var.network_regions, count.index)}-net"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "dataproc-cluster-subnet" {
  depends_on = [
    "google_compute_network.dataproc-cluster-net",
  ]

  count         = "${length(var.network_regions)}"
  name          = "dp-${lookup(var.network_regions, count.index)}-net"
  region        = "${lookup(var.network_regions, count.index)}"
  network       = "dp-${lookup(var.network_regions, count.index)}-net"
  ip_cidr_range = "${lookup(var.network_cidrs, count.index)}"
}

# Firewall rules for intra-cluster member communication
# https://cloud.google.com/dataproc/docs/concepts/network
resource "google_compute_firewall" "dp-firewall" {
  depends_on = [
    "google_compute_network.dataproc-cluster-net",
    "google_compute_subnetwork.dataproc-cluster-subnet",
  ]

  count         = "${length(var.network_regions)}"
  name          = "allow-all-intra-cluster-${lookup(var.network_regions, count.index)}"
  network       = "dp-${lookup(var.network_regions, count.index)}-net"
  source_ranges = ["${lookup(var.network_cidrs, count.index)}"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}
