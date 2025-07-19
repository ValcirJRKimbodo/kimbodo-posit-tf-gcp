output "gke_endpoint" {
  value       = module.gke.cluster_endpoint
  description = "Kubecl address (remember to grant with gcloud auth)"
}
output "statc_ip_address" {
  value       = module.statc_ip.address
  description = "public IP"
}
