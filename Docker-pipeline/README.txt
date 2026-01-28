Suposiciones, EC2 en public subnet (simplificación)

Crear terraform modulos:

entorno
-pro
--maint.tf
--terraform.tfvars
-pre(opcional)
--main.tf
--terraform.tfvars

modules
-ec2
--main.tf
--outputs.tf
-Secrets
--main.tf

deploy
-docker-compose.yml

.github/
-workflows/


Crear EC2 instance with Amazon Linux or Ubuntu. en el modulo ec2 main.tf, crear Security group for the instance. en main.tf si es necesario que el Docker esté funcionando cuando se arranque la instancia usar user_data para arrancar el Docker. finalmente crear la pipeline con la carpeta pipeline y ejecutarla en el docker

-- para los opcional, 
 - Store en AWS Secret manager, crear el secrets con main.tf y pipeline lee 
 - para el multiple environments con la diferenciación de los módulos, solo sería crear un nuevo entorno pre, y llamar a los modulos.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

 # Prometheus & Grafana on AWS EC2 - DevOps Challenge

### 💡 Architecture Philosophy

┌───────────────────────────────────────────────────────────────┐
│                       GitHub Repository                        │
│                                                               │
│  ┌───────────────┐   ┌───────────────┐   ┌───────────────┐  │
│  │ env/pro/      │   │ modules/      │   │ deploy/       │  │
│  │ (Terraform)   │   │ (reusable IaC)│   │ (app config)  │  │
│  └───────────────┘   └───────────────┘   └───────────────┘  │
│                                                               │
└───────────────────────────────┬───────────────────────────────┘
                                │ git push (main)
                                ▼
┌───────────────────────────────────────────────────────────────┐
│                    GitHub Actions Workflow                     │
│                                                               │
│  1. tofu init & apply (provision infrastructure)              │
│  2. Read Terraform outputs (instance_id, URLs)                │
│  3. Fetch Grafana credentials from AWS Secrets Manager         │
│  4. Package deploy/ folder (tar + base64)                     │
│  5. Execute remote deployment via AWS SSM Run Command          │
│                                                               │
└───────────────────────────────┬───────────────────────────────┘
                                │ SSM Agent
                                ▼
┌───────────────────────────────────────────────────────────────┐
│                        AWS EC2 Instance                        │
│                                                               │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  /opt/monitoring/deploy/                                │ │
│  │  ├── docker-compose.yml                                 │ │
│  │  ├── prometheus/prometheus.yml                          │ │
│  │  └── grafana/provisioning/                              │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                               │
│           │                                                   │
│           ▼                                                   │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │              Docker Compose Services                    │ │
│  │                                                         │ │
│  │   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐ │ │
│  │   │ Prometheus  │   │ Grafana     │   │ Node Export │ │ │
│  │   │ :9090       │   │ :3000       │   │ :9100       │ │ │
│  │   └─────────────┘   └─────────────┘   └─────────────┘ │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                               │
└───────────────────────────────────────────────────────────────┘


### What Gets Created

When you deploy this project, the following AWS resources are provisioned:

```
EC2 Instance (Amazon Linux 2023)
├── Security Group (ingress: SSH 22, Prometheus 9090, Grafana 3000, node_exporter 9100)
├── IAM Role (AmazonSSMManagedInstanceCore)
├── Instance Profile
└── EBS Volume (gp3, 20 GB)

AWS Secrets Manager
└── grafana-credentials (username + password)

SSM Parameter Store (optional)
└── /monitoring/prometheus-config (versioned config)
```

**Deployed Services (via Docker Compose):**

| Service | Port | Purpose | Metrics Retention |
|---------|------|---------|-------------------|
| **Prometheus** | 9090 | Time-series database, scraping | 15 days (default) |
| **Grafana** | 3000 | Visualization, dashboards | N/A (queries Prometheus) |
| **Node Exporter** | 9100 | Host metrics (CPU, RAM, disk) | Real-time |


CI/CD Pipeline

git push
   ↓
GitHub Actions
   ↓
Terraform provisions infra
   ↓
Secrets fetched from AWS Secrets Manager
   ↓
SSM Run Command executes deployment
   ↓
Docker Compose runs Prometheus + Grafana

After deployment

Prometheus UI available at: http://<EC2_PUBLIC_IP>:9090

Grafana UI available at: http://<EC2_PUBLIC_IP>:3000


## Architecture

### Directory Structure

```
Docker-pipeline/
├── env/
│   └── pro/                          # Production environment
│       ├── main.tf                   # Root module, calls modules/ec2
│       ├── variables.tf              # Input variables (region, instance_type, etc.)
│       ├── outputs.tf                # Outputs: instance_id, URLs, secret_name
│       ├── provider.tf               # AWS provider configuration
│       ├── version.tf                # Required providers & versions
│       └── terraform.tfvars          # Environment-specific values
│
├── modules/
│   ├── ec2/                          # Reusable EC2 module
│   │   ├── main.tf                   # EC2, SG, IAM role/profile
│   │   ├── data.tf                   # data "aws_ami" for dynamic lookup
│   │   ├── variables.tf              # Module input variables
│   │   ├── outputs.tf                # Instance ID, public IP, etc.
│   │   └── user_data.sh              # Bootstrap script (Docker only)
│   │
│   └── secrets/                      # Reusable Secrets Manager module
│       ├── main.tf                   # Random password generator + secret
│       └── outputs.tf                # Secret ARN, secret name
│
├── deploy/                           # Application deployment artifacts
│   ├── docker-compose.yml            # Service definitions
│   ├── prometheus/
│   │   └── prometheus.yml            # Scrape configs, retention policy
│   └── grafana/
│       └── provisioning/
│           └── datasources/          # Auto-provision Prometheus datasource
│
├── .github/
│   └── workflows/
│       └── deploy.yml                # CI/CD pipeline (tofu + SSM)
│
|
└── README.md                         # This file
```
