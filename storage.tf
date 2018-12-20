# Create a bucket for "init script"
resource "google_storage_bucket" "dataproc_init_bucket" {
  name          = "${var.dproc_config}"
  storage_class = "NEARLINE"
  location      = "us-west2"
}
resource "google_storage_bucket_object" "dataproc_init_script" {
  name   = "define-dproc-cluster.sh"
  source = "define-dproc-cluster.sh"
  bucket = "${google_storage_bucket.dataproc_init_bucket.name}"
}
