module "vpc" {
  source          = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/vpc?ref=feature/add_gcp"
  vpc_name        = var.vpc_name
  vpc_description = "VPC for Posit MVP infrastructure"
}
module "subnet" {
  source          = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/subnet?ref=feature/add_gcp"
  subnet_name     = var.subnet_name
  primary_cidr    = var.primary_cdr
  pods_range_name = "gke-pods"
  pods_cidr       = var.pods_cdr
  region          = var.region
  vpc_id          = module.vpc.vpc_id
}
module "gke" {
  source              = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/gke?ref=feature/add_gcp"
  cluster_name        = var.gke_name
  region              = var.region
  network             = module.vpc.vpc_id
  subnetwork          = module.subnet.subnet_id
  pods_range_name     = module.subnet.pods_range_name
  deletion_protection = false
}
module "primary_nodepool" {
  source             = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/node_pool?ref=feature/add_gcp"
  name               = var.primary_nodepool_name
  cluster_name       = module.gke.cluster_name
  region             = var.region
  machine_type       = var.primary_node_pool_macinhe
  enable_autoscaling = false
  fixed_node_count   = 2
  node_labels = {
    apptype = "workspaces"
  }
}
module "secondary_nodepool" {
  source             = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/node_pool?ref=feature/add_gcp"
  name               = var.secondary_nodepool_name
  cluster_name       = module.gke.cluster_name
  region             = var.region
  machine_type       = var.secondary_node_pool_macinhe
  enable_autoscaling = true
  node_labels = {
    apptype = "sessionsholder"
  }
}

module "statc_ip" {
  source = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/static_ip?ref=feature/add_gcp"
  name   = var.reserved_ip_name
  region = var.region
}