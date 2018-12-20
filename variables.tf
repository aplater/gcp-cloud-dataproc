# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

variable "nest_compute_roles" {
  description = "list of IAM roles for nest node service account"
  type        = "list"
}

variable "network_regions" {
  type = "map"

  default = {
    "0" = "us-west1"
    "1" = "us-west2"
    "2" = "us-central1"
    "3" = "us-east1"
    # "4" = "us-east4" Quota is 5 networks globally (default + 4)
  }
}

variable "network_cidrs" {
  type = "map"

  default = {
    "0" = "10.40.0.0/28"
    "1" = "10.50.1.0/28"
    "2" = "10.60.2.0/28"
    "3" = "10.70.3.0/28"
    # "4" = "10.80.4.0/28" Quota is 5 networks globally (default + 4)
  }
}
