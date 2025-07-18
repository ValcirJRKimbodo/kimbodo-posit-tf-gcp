# output "gke_endpoint" {
#   value       = module.gke.cluster_endpoint
#   description = "Endereço para kubectl (lembre de gerar credenciais com gcloud/container auth)"
# }

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}
