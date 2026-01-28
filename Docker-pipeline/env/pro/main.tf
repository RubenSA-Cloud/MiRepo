module "ec2" {
  source = "../../modules/ec2"

  name          = var.name
  instance_type  = var.instance_type
  allowed_cidrs  = var.allowed_cidrs
  enable_ssh     = var.enable_ssh
  ssh_key_name   = var.ssh_key_name
}

module "secrets" {
  source = "../../modules/secrets"

  name               = var.name
  grafana_admin_user  = var.grafana_admin_user
  password_length     = var.grafana_password_length
}
