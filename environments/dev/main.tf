provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}

module "dev-vpc" {
    source      = "../../../tf-modules/gcp-vpc"
    
    name = "tf-vpc"
    auto_create_subnetworks = "false"
    vpc_cidr = "192.168.0.0/24"
    subnet_cidr = ["192.168.1.0/26", "192.168.1.64/26"]
    subnet_region = "us-east1"
}

module "dev-vm" {
    source      = "../../../tf-modules/gcp-vm"
    
    name = "tf-vm"
    machine_type = "f1-micro"
    image = "debian-cloud/debian-9"
    vpc    = "${module.dev-vpc.vpc_self_link}"
}