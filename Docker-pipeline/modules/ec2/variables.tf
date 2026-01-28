variable "name" {
  type        = string
  description = "Base name for resources"
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
