# create the service account for our cluster worker nodes
resource "google_service_account" "dataproc-wkr-sa" {
  account_id   = "wn-per-cluster-compute"
  display_name = "dataproc worker node service account"
}

# Apply Data Proc worker role to service account
resource "google_project_iam_member" "dataproc_worker_member" {
  project = "${var.project}"
  count   = "${length(var.worker_node_roles)}"
  role    = "${element(var.worker_node_roles, count.index)}"
  member  = "serviceAccount:${google_service_account.dataproc-wkr-sa.email}"
}

# create the service account for our app compute nodes
resource "google_service_account" "dataproc-app-compute-sa" {
  account_id   = "app-compute-node"
  display_name = "dataproc app compute node service account"
}

# Apply appropriate cloud storage role to service account
resource "google_project_iam_member" "dataproc_app_compute_member" {
  project = "${var.project}"
  count   = "${length(var.app_compute_roles)}"
  role    = "${element(var.app_compute_roles, count.index)}"

  #TODO Clean up the roles ^^
  member = "serviceAccount:${google_service_account.dataproc-app-compute-sa.email}"
}
