# add our providers
provider google {
  region  = "${var.region}"
  project = "${var.project}"
}

provider "local" {}
