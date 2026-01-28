output "instance_id" {
  value       = aws_instance.this.id
  description = "EC2 instance ID"
}

output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "EC2 public IP"
}

output "grafana_url" {
  value       = "http://${aws_instance.this.public_ip}:3000"
  description = "Grafana URL"
}

output "prometheus_url" {
  value       = "http://${aws_instance.this.public_ip}:9090"
  description = "Prometheus URL"
}
