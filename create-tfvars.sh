#!/bin/bash

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

export GOOGLE_PROJECT=$(gcloud config get-value project)
export DPROC_CONFIG="$(uuidgen | tr "[:upper:]" "[:lower:]")"
export MY_PUBLIC_IPV4=$(curl https://api.ipify.org)

cat - > terraform.tfvars <<EOF
# project properties
project="${GOOGLE_PROJECT}"
dproc_config="${DPROC_CONFIG}"
name="${GOOGLE_PROJECT}"
region="us-west2"

# bind roles to compute service accounts:
worker_node_roles = ["roles/dataproc.worker"]
nest_compute_roles = ["roles/storage.objectCreator"]

# define network properties
network_name="${GOOGLE_PROJECT}-net"
ssh_source_ranges="${MY_PUBLIC_IPV4}/32"

EOF
