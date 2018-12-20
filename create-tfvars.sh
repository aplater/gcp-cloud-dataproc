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

EOF
