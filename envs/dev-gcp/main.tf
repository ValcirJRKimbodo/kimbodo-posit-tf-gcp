module "vpc" {
  source          = "git::https://github.com/nkopskimbodo/kimbodo-tf-multicloud-modules//gcp/vpc?ref=feature/add_gcp"
  vpc_name        = "posit-application-vpc"
  vpc_description = "VPC for Posit MVP infrastructure"
  region          = var.region
}
