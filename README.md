🧱 VDC Admin Portal Utils

A centralized repository for reusable infrastructure modules, shared libraries, and common utilities used across all VDC Admin Portal workloads.
This repository provides modular Terraform building blocks and backend/frontend shared libraries to promote consistency, reusability, and maintainability across environments.

🏗️ Project Structure

```
vdc-admin-portal-utils/
├── .github/                     # CI/CD workflows for linting, validation & release
│   └── workflows/
├── backend/                     # Shared backend Go libraries
│   └── libraries/
│       ├── common-authz/        # Authentication & Authorization utilities
│       ├── logging/             # Centralized structured logging
│       └── tracing/             # OpenTelemetry-based tracing setup
├── frontend/                    # Shared frontend libraries
│   └── libraries/
│       ├── api-client/          # Shared API client utilities
│       └── ui-kit/              # Common UI components and styling kit
├── terraform/                   # Core reusable Terraform modules
│   ├── examples/
│   │   └── aks-basic/           # Example usage for AKS module
│   ├── modules/                 # Versioned reusable Terraform modules
│   │   ├── aks/                 # Azure Kubernetes Service setup
│   │   ├── cosmosdb/            # Cosmos DB with private networking
│   │   ├── firewall/            # Azure Firewall and rules management
│   │   ├── key-vault/           # Azure Key Vault provisioning
│   │   ├── nginx-gateway-fabric/# NGINX Gateway Fabric module
│   │   ├── postgres-flex/       # Azure Postgres Flexible Server
│   │   ├── private-endpoint/    # Private Endpoint module
│   │   ├── sendgrid/            # SendGrid configuration module
│   │   └── vnet/                # VNet / subnet provisioning
│   │       └── examples/
│   │           └── basic/
│   └── test/                    # Terraform module tests (e.g. terratest)
└── docs/                        # Documentation for modules, usage, and release

```

🌍 Purpose

The vdc-admin-portal-utils repo serves as a shared foundation for:

Infrastructure as Code (Terraform modules) across all workloads.

Backend & frontend shared libraries.

Consistent CI/CD templates and documentation.

Standardized deployment patterns for the VDC ecosystem.

🚀 Quick Start
Prerequisites

Terraform: ≥ 1.12.2

Go: ≥ 1.24 (for backend libraries)

Node.js: ≥ 18 (for frontend libraries)

Make: ≥ 4.0

Azure CLI (if provisioning Azure infra locally)

Clone & Setup
git clone https://github.com/Veeam-VDC/vdc-admin-portal-utils.git
cd vdc-admin-portal-utils


Initialize submodules, if any:

git submodule update --init --recursive

🧩 Terraform Modules Overview

Each Terraform module under terraform/modules/ is designed to be independently versioned and consumed by other repositories (e.g., vdc-entra-admin-portal, vdc-entra-id, etc.).

```
Module	Description	Example Path
vnet	Creates virtual networks, subnets, and optional peering	terraform/modules/vnet
aks	Provisions Azure Kubernetes Service clusters	terraform/modules/aks
cosmosdb	Cosmos DB account with private endpoint & key rotation	terraform/modules/cosmosdb
key-vault	Azure Key Vault + secrets setup	terraform/modules/key-vault
private-endpoint	Generic Private Endpoint reusable module	terraform/modules/private-endpoint
postgres-flex	PostgreSQL Flexible Server (with private access)	terraform/modules/postgres-flex
firewall	Azure Firewall setup with rule collections	terraform/modules/firewall
nginx-gateway-fabric	NGF gateway deployment and routing config	terraform/modules/nginx-gateway-fabric
sendgrid	SendGrid account + API key integration	terraform/modules/sendgrid

```
Example Usage
module "vnet" {
  source   = "github.com/Veeam-VDC/vdc-admin-portal-utils//terraform/modules/vnet?ref=v1.0.0"
  location = "westeurope"
  name     = "vdc-vnet-dev"
  cidr     = "10.32.0.0/16"
}

⚙️ Development & Validation
Linting & Validation
# Validate all Terraform modules
make terraform-validate

# Lint Terraform code
make terraform-lint

Test Modules (via Terratest)
cd terraform/test
go test -v ./...

Example Deployment
cd terraform/examples/aks-basic
terraform init
terraform apply

🧱 Backend Libraries (Placeholder)

The backend/libraries/ directory currently serves as a placeholder for future shared backend code.
It will host common Go-based libraries such as:

common-authz → shared authentication and authorization helpers

logging → unified structured logging utilities

tracing → OpenTelemetry tracing and metrics setup

Note: These directories are currently empty examples and will be populated in future releases.

🎨 Frontend Libraries (Placeholder)

The frontend/libraries/ directory is a placeholder for shared frontend utilities.
In future, it will include:

api-client → shared API wrapper and interceptors

ui-kit → reusable React components and design tokens

Note: These are sample placeholders — implementation will be added in upcoming iterations.
<Button variant="primary">Deploy</Button>;

🧰 CI/CD Integration

Workflows: All GitHub Actions live under .github/workflows/

Terraform release tagging: Versioned module tagging strategy → vnet/v1.2.0, aks/v0.9.1, etc.

Automatic validation: PR checks ensure module format, lint, and example validation before merge.

🧪 Testing Strategy

Terraform Modules: Validated with terraform validate, tflint, and optional Terratest.

Golang Libraries: Unit tested via go test ./....

Frontend Packages: Tested with Jest or Vitest (depending on library).

🏷️ Versioning Strategy

Each Terraform module and library is independently versioned using semantic versioning (vX.Y.Z) and published via Git tags:

terraform/modules/vnet → tag: vnet/v1.2.0
terraform/modules/aks → tag: aks/v0.9.0

📖 Documentation

Terraform Modules: docs/terraform-modules.md

Backend Libraries: docs/backend-libraries.md

Frontend Libraries: docs/frontend-libraries.md

Release Notes: CHANGELOG.md

🤝 Contributing

Fork the repo and create a feature branch.

Make changes in the relevant module/library directory.

Run validation & tests:

terraform-lint
terraform-validate

Open a PR with clear changelog entries.

Ensure module version bump and tagging before merge.

🔗 Related Repositories

VDC Entra Admin Portal

VDC Control Plane Admin Portal

📜 License

© 2025 Veeam Software — All Rights Reserved.
This repository is part of the VDC Admin Portal ecosystem.
