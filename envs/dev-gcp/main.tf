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
module "gke" {
  source              = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/gke?ref=feature/add_gcp"
  cluster_name        = "posit-cluster-mvp"
  region              = var.region
  network             = module.vpc.vpc_id
  subnetwork          = module.subnet.subnet_id
  pods_range_name     = module.subnet.pods_range_name
  deletion_protection = false
}
module "primary_nodepool" {
  source             = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/node_pool?ref=feature/add_gcp"
  name               = "primary"
  cluster_name       = module.gke.cluster_name
  region             = var.region
  machine_type       = "e2-small"
  enable_autoscaling = false
  fixed_node_count   = 2
  node_labels = {
    apptype = "workspaces"
  }
}
module "secondary_nodepool" {
  source             = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/node_pool?ref=feature/add_gcp"
  name               = "secondary"
  cluster_name       = module.gke.cluster_name
  region             = var.region
  machine_type       = "n2-highmem-4"
  enable_autoscaling = true
  node_labels = {
    apptype = "sessionsholder"
  }
}