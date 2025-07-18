module "vpc" {
  source          = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/vpc?ref=feature/add_gcp"
  vpc_name        = "posit-terraform-vpc"
  vpc_description = "VPC for Posit MVP infrastructure"
}
module "subnet" {
  source          = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/subnet?ref=feature/add_gcp"
  subnet_name     = "subnet-posit-us-central1"
  primary_cidr    = "10.10.0.0/24"
  pods_range_name = "gke-pods"
  pods_cidr       = "10.136.0.0/14"
  region          = var.region
  vpc_id          = module.vpc.vpc_id
}
