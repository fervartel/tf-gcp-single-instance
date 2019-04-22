provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

module "dev-vpc" {
    source      = "../../../tf-modules/gcp-vpc"
    
    name = "tf-vpc"
    auto_create_subnetworks = "true"
}

module "dev-vm" {
    source      = "../../../tf-modules/gcp-vm"
    
    name = "tf-vm"
    machine_type = "f1-micro"
    image = "debian-cloud/debian-9"
    vpc    = "${module.dev-vpc.vpc_self_link}"
}

# resource "google_compute_instance" "vm_instance" {
#   name         = "tf-instance"
#   machine_type = "f1-micro"

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-9"
#     }
#   }

#   network_interface {
#     # # A default network is created for all GCP projects
#     # network       = "default"
#     network = "${google_compute_network.vpc_network.self_link}"
#     access_config = {
#     }
#   }
# }