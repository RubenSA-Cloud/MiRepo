resource "random_password" "grafana_admin" {
  length  = var.password_length
  special = true
}

resource "aws_secretsmanager_secret" "grafana" {
  name = "${var.name}-grafana-admin"
}

resource "aws_secretsmanager_secret_version" "grafana" {
  secret_id = aws_secretsmanager_secret.grafana.id

  secret_string = jsonencode({
    username = var.grafana_admin_user
    password = random_password.grafana_admin.result
  })
}