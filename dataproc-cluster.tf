#### Create a GCP cloud dataproc cluster: ###
# Define our Cloud Dataproc cluster
resource "google_dataproc_cluster" "demo-dataproc-cluster" {
  # Await key resources to be created: 
  depends_on = [
    "google_service_account.dataproc-wkr-sa",
    "google_project_iam_member.dataproc_worker_member",
    "google_storage_bucket_object.dataproc_init_script",
    "google_compute_network.dataproc-cluster-net",
    "google_compute_subnetwork.dataproc-cluster-subnet",
    "google_compute_firewall.dp-firewall",
  ]

  count = "${length(var.network_regions)}"

  name   = "dp-cluster-${lookup(var.network_regions, count.index)}-net"
  region = "${lookup(var.network_regions, count.index)}"

  cluster_config {
    master_config {
      num_instances = 1
      machine_type  = "${var.machine_type}"

      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 20
      }
    }

    worker_config {
      num_instances = 2
      machine_type  = "${var.machine_type}"

      disk_config {
        boot_disk_size_gb = 20
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "${var.image_version}"

      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      subnetwork      = "dp-${lookup(var.network_regions, count.index)}-net"
      service_account = "${google_service_account.dataproc-wkr-sa.email}"

      # TODO ^^ Get specified service account working

      service_account_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
      ]

      #TODO Clean up the scopes ^^
    }

    initialization_action {
      script = "gs://${google_storage_bucket.dataproc_init_bucket.name}/${google_storage_bucket_object.dataproc_init_script.name}"

      # ^^ Cluster init script
      # define-dproc-cluster.sh

      timeout_sec = 500
    }
  }
}
