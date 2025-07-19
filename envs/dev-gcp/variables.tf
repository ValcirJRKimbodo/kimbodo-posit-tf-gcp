variable "project_id" { type = string }
variable "region" {
  type    = string
  default = "us-central1"
}
variable "vpc_name" {
  type = string
  default = "kimbodo-posit-vpc"  
}
variable "subnet_name" {
  type = string
  default = "kimbodo-posit-subnet"  
}
variable "reserved_ip_name" {
  type = string
  default = "kimbodo-posit-reserved-ip"  
}
variable gke_name {
  type = string
  default = "kimbodo-posit-cluster"
}

variable "primary_cdr" {
  type = string
  default = "10.10.0.0/24"
}

variable "pods_cdr" {
  type = string
  default = "10.136.0.0/14"  
}
variable primary_nodepool_name {
  type = string
  default = "primary"
}
variable secondary_nodepool_name {
  type = string
  default = "secondary"
}

variable primary_node_pool_macinhe {
  type = string
  default = "e2-small"
}
variable secondary_node_pool_macinhe {
  type = string
  default = "n2-highmem-4"
}