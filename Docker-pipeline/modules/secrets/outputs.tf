output "grafana_secret_arn" {
  value       = aws_secretsmanager_secret.grafana.arn
  description = "ARN of the Grafana admin secret"
}

output "grafana_secret_name" {
  value       = aws_secretsmanager_secret.grafana.name
  description = "Name of the Grafana admin secret"
}
