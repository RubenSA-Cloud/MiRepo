variable "region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-1"
}

variable "name" {
  type        = string
  description = "Base name for resources"
  default     = "sentisis-monitoring-pro"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to access Grafana/Prometheus (and optionally SSH)"
  default     = ["0.0.0.0/0"]
}

variable "enable_ssh" {
  type        = bool
  description = "Whether to open port 22"
  default     = false
}

variable "ssh_key_name" {
  type        = string
  description = "EC2 key pair name, required if enable_ssh=true"
  default     = null
}


#Variables de secret
variable "grafana_admin_user" {
  type        = string
  description = "Grafana admin username"
  default     = "admin"
}

variable "grafana_password_length" {
  type        = number
  description = "Length of generated Grafana admin password"
  default     = 20
}

