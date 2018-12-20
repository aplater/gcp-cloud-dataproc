variable project {
  description = "Specify the project"
}

variable name {
  description = "Specify a name prefix"
}

variable region {
  description = "Specify the region"
}

variable network_name {
  description = "Specify the network name"
}

variable dproc_config {
  description = "Specify a gcs bucket name for dataproc init script"
}

variable "private_ip_google_access" {
  default = true
}

variable auto_create_subnetworks {
  default = false
}

variable machine_type {
  default = "n1-standard-1"
}

variable "image_version" {
  default = "1.3.7-deb9"
}

variable "worker_node_roles" {
  description = "list of IAM roles for worker node service account"
  type        = "list"
}

variable "app_compute_roles" {
  description = "list of IAM roles for app compute node service account"
  type        = "list"
}

variable "network_regions" {
  type = "map"
  description = "list of required network regions"
}

variable "network_cidrs" {
  type = "map"
  description = "list of required network cidrs"
}

