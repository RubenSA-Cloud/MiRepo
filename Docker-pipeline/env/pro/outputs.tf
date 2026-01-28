output "instance_id" {
  value       = module.ec2.instance_id
  description = "EC2 instance ID"
}

output "public_ip" {
  value       = module.ec2.public_ip
  description = "EC2 public IP"
}

output "grafana_url" {
  value       = module.ec2.grafana_url
  description = "Grafana URL"
}

output "prometheus_url" {
  value       = module.ec2.prometheus_url
  description = "Prometheus URL"
}

#Secrets outputs
output "grafana_secret_arn" {
  value       = module.secrets[0].grafana_secret_arn
  description = "Grafana secret ARN"
}

output "grafana_secret_name" {
  value       = module.secrets[0].grafana_secret_name
  description = "Grafana secret name"
}
