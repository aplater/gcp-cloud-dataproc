#!/bin/bash

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
app_compute_roles = ["roles/storage.objectCreator"]

# define network properties
network_name="${GOOGLE_PROJECT}-net"
ssh_source_ranges="${MY_PUBLIC_IPV4}/32"

network_regions = {
    "0" = "us-west1"
    "1" = "us-west2"
    "2" = "us-central1"
    "3" = "us-east1"
  }

network_cidrs = {
    "0" = "10.40.0.0/28"
    "1" = "10.50.1.0/28"
    "2" = "10.60.2.0/28"
    "3" = "10.70.3.0/28"
  }

EOF
