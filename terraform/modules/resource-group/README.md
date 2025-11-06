# Azure Resource Group Module

This Terraform module creates and manages Azure Resource Groups with optional management locks to prevent accidental deletion.

## Overview

The Resource Group module provides:
- **Multiple Resource Group Creation**: Deploy one or more Azure Resource Groups in a single module call
- **Management Locks**: Optional `CanNotDelete` locks to protect resource groups from accidental deletion
- **Flexible Configuration**: Per-resource group settings for location, tags, and lock policies
- **Output Maps**: Easy reference to created resource group IDs and names for use in other modules

## Module Structure

```
terraform/modules/resource-group/
├── main.tf           # Resource definitions (resource groups and locks)
├── variables.tf      # Input variable definitions
├── outputs.tf        # Output value definitions
├── versions.tf       # Terraform and provider version constraints
└── README.md         # This file
```

## Version Information

**Current Stable Version**: `resource-group/v1.0.0`

This module follows a versioning scheme where each module is tagged independently:
- Tag format: `<module-name>/v<version>`
- Example: `resource-group/v1.0.0`

## Usage

### From Your Monorepo (ran130987wan/monorepo-pipeline)

**⚠️ Important**: Always use the tagged version in production to ensure stability and reproducibility.

#### Recommended: Using Tagged Version (Production)

```hcl
module "resource_groups" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"

  resource_groups = [
    {
      name     = "rg-production-eastus"
      location = "eastus"
      locks    = true
      tags = {
        Environment = "Production"
        ManagedBy   = "Terraform"
        Owner       = "Platform-Team"
      }
    },
    {
      name     = "rg-development-westus"
      location = "westus"
      locks    = false
      tags = {
        Environment = "Development"
        ManagedBy   = "Terraform"
        Owner       = "Dev-Team"
      }
    }
  ]
}
```

### Referencing Different Versions

```hcl
# ✅ RECOMMENDED: Using the module-specific tag (Production)
source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"

# ✅ Using a specific version when available
source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.1.0"

# ⚠️ Using main branch (not recommended for production)
source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=main"

# ⚠️ Using a feature branch (for testing only)
source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=ranjit/modules"
```

### Local Development

For local development and testing within this repository:

```hcl
module "resource_groups" {
  source = "./terraform/modules/resource-group"

  resource_groups = [
    {
      name     = "rg-test-eastus"
      location = "eastus"
      locks    = false
      tags     = { Environment = "Test" }
    }
  ]
}
```

## Input Variables

### `resource_groups` (Required)

A list of objects defining resource group configurations.

**Type**: `list(object)`

**Schema**:
```hcl
list(object({
  name        = string                      # Resource group name (must be unique in Azure subscription)
  location    = string                      # Azure region (e.g., "eastus", "westus", "centralus")
  locks       = bool                        # Enable CanNotDelete lock (true/false)
  tags        = optional(map(string), {})   # Key-value pairs for resource tagging
}))
```

**Default**: `[]` (empty list)

**Example**:
```hcl
resource_groups = [
  {
    name     = "rg-app-prod-eastus"
    location = "eastus"
    locks    = true
    tags = {
      Environment = "Production"
      Application = "WebApp"
      CostCenter  = "CC-1234"
    }
  },
  {
    name     = "rg-data-prod-westus"
    location = "westus"
    locks    = true
    tags = {
      Environment = "Production"
      Application = "DataPlatform"
      CostCenter  = "CC-5678"
    }
  }
]
```

## Outputs

### `resource_group_ids`

A map of resource group names to their Azure resource IDs.

**Type**: `map(string)`

**Example Output**:
```hcl
{
  "rg-app-prod-eastus"  = "/subscriptions/xxxx-xxxx-xxxx-xxxx/resourceGroups/rg-app-prod-eastus"
  "rg-data-prod-westus" = "/subscriptions/xxxx-xxxx-xxxx-xxxx/resourceGroups/rg-data-prod-westus"
}
```

**Usage in Other Modules**:
```hcl
# Reference in another module
resource "azurerm_storage_account" "example" {
  resource_group_name = module.resource_groups.resource_group_names["rg-app-prod-eastus"]
  # ... other config
}
```

### `resource_group_names`

A map of resource group names (as keys) to their actual names (as values).

**Type**: `map(string)`

**Example Output**:
```hcl
{
  "rg-app-prod-eastus"  = "rg-app-prod-eastus"
  "rg-data-prod-westus" = "rg-data-prod-westus"
}
```

## Resources Created

### `azurerm_resource_group.this`

Creates Azure Resource Groups based on the `resource_groups` input list.

- Uses `for_each` to iterate through all resource group configurations
- Creates a map with resource group name as the key
- Applies name, location, and tags as specified

### `azurerm_management_lock.rg_lock`

Creates management locks on resource groups where `locks = true`.

- **Lock Level**: `CanNotDelete` - Prevents deletion but allows read and modify operations
- **Lock Name**: `<resource-group-name>-lock`
- **Scope**: Applied to the entire resource group
- **Conditional Creation**: Only created when `locks = true` in the resource group configuration

## Requirements

### Terraform Version

- **Minimum**: `>= 1.12.0`

### Provider Requirements

```hcl
azurerm = {
  source  = "hashicorp/azurerm"
  version = "~> 4.0"
}
```

### Authentication

Ensure you have Azure authentication configured before running this module:

```bash
# Using Azure CLI
az login

# Or using Service Principal
export ARM_CLIENT_ID="<client-id>"
export ARM_CLIENT_SECRET="<client-secret>"
export ARM_SUBSCRIPTION_ID="<subscription-id>"
export ARM_TENANT_ID="<tenant-id>"
```

## Complete Real-World Example

### Example from monorepo-pipeline Repository

This example shows how to use the module in a production monorepo structure with centralized configuration and environment-specific variables.

**Repository**: https://github.com/ran130987wan/monorepo-pipeline.git

**Folder Structure**:
```
monorepo-pipeline/
└── platform/
    └── terraform/
        ├── global/
        │   ├── locals.tf          # Local values and transformations
        │   ├── main.tf            # Module configuration
        │   ├── variables.tf       # Variable definitions
        │   ├── outputs.tf         # Output definitions
        │   ├── providers.tf       # Provider and backend configuration
        │   └── versions.tf        # Version constraints
        └── envs/
            └── dev/
                └── global-vars/
                    └── main.tfvars    # Environment-specific values
```

#### Step 1: Define Local Variables (`platform/terraform/global/locals.tf`)

```hcl
locals {
  # Define resource group types for different workloads
  resource_groups_map = {
    container = {
      name = "container"
      type = "container"
    },
    web = {
      name = "web"
      type = "web"
    },
    security = {
      name = "security"
      type = "security"
    },
    data = {
      name = "data"
      type = "data"
    },
    monitoring = {
      name = "monitoring"
      type = "monitoring"
    },
    network = {
      name = "network"
      type = "network"
    },
    platform = {
      name = "platform"
      type = "platform"
    },
    integration = {
      name = "integration"
      type = "integration"
    }
  }
  
  # Get region code from mapping
  region_code = var.azure_region_map[var.global_config.location]
  
  # Enable locks for production and staging environments
  enable_resource_group_lock = var.global_config.environment == "prod" || var.global_config.environment == "stage" ? true : false
}
```

#### Step 2: Configure the Module (`platform/terraform/global/main.tf`)

```hcl
# Transform the resource groups map into the format expected by the module
locals {
  resource_groups = [
    for rg in locals.resource_groups_map : {
      name     = "${var.global_config.compact_prefix}-${rg.name}-rg-${var.global_config.environment}"
      location = var.global_config.location
      locks    = locals.enable_resource_group_lock
      tags     = var.global_config.tags
    }
  ]
}

# Call the resource-group module from terraform-modules repository
module "resource_groups" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"
  
  resource_groups = locals.resource_groups
}
```

#### Step 3: Define Variables (`platform/terraform/global/variables.tf`)

```hcl
variable "global_config" {
  description = "Global configuration for resource naming and tagging"
  type = object({
    prefix         = string
    compact_prefix = string
    environment    = string
    location       = string
    region_code    = string
    tags           = map(string)
  })
}

variable "azure_region_map" {
  description = "Mapping of Azure region names to short codes"
  type        = map(string)
  default = {
    "eastus"             = "eus"
    "eastus2"            = "eus2"
    "westus"             = "wus"
    "westus2"            = "wus2"
    "centralus"          = "cus"
    "southcentralus"     = "scus"
    "northcentralus"     = "ncus"
    "westcentralus"      = "wcus"
    "uksouth"            = "uks"
    "ukwest"             = "ukw"
    "northeurope"        = "neu"
    "westeurope"         = "weu"
    "southeastasia"      = "sea"
    "eastasia"           = "ea"
    "australiaeast"      = "aue"
    "australiasoutheast" = "ause"
    "brazilsouth"        = "brs"
    "brazilsoutheast"    = "brse"
    "canadacentral"      = "canc"
    "canadaeast"         = "cane"
    "indiawest"          = "inw"
    "indiasouth"         = "ins"
    "indianorth"         = "inn"
    "koreacentral"       = "korc"
    "koreasouth"         = "kors"
    "southafricanorth"   = "san"
    "southafricawest"    = "saw"
    "japaneast"          = "jpe"
    "japanwest"          = "jpw"
    "swedencentral"      = "swc"
  }
}
```

#### Step 4: Define Outputs (`platform/terraform/global/outputs.tf`)

```hcl
# Output all resource group IDs
output "resource_group_ids" {
  description = "Map of resource group names to their Azure resource IDs"
  value       = module.resource_groups.resource_group_ids
}

# Output all resource group names
output "resource_group_names" {
  description = "Map of resource group names to their display names"
  value       = module.resource_groups.resource_group_names
}

# Output specific resource groups for easy reference in other modules
output "container_rg_id" {
  description = "Resource ID of the container resource group"
  value       = module.resource_groups.resource_group_ids["${var.global_config.compact_prefix}-container-rg-${var.global_config.environment}"]
}

output "web_rg_id" {
  description = "Resource ID of the web resource group"
  value       = module.resource_groups.resource_group_ids["${var.global_config.compact_prefix}-web-rg-${var.global_config.environment}"]
}

output "data_rg_id" {
  description = "Resource ID of the data resource group"
  value       = module.resource_groups.resource_group_ids["${var.global_config.compact_prefix}-data-rg-${var.global_config.environment}"]
}

output "network_rg_id" {
  description = "Resource ID of the network resource group"
  value       = module.resource_groups.resource_group_ids["${var.global_config.compact_prefix}-network-rg-${var.global_config.environment}"]
}

output "security_rg_id" {
  description = "Resource ID of the security resource group"
  value       = module.resource_groups.resource_group_ids["${var.global_config.compact_prefix}-security-rg-${var.global_config.environment}"]
}

output "monitoring_rg_id" {
  description = "Resource ID of the monitoring resource group"
  value       = module.resource_groups.resource_group_ids["${var.global_config.compact_prefix}-monitoring-rg-${var.global_config.environment}"]
}

output "platform_rg_id" {
  description = "Resource ID of the platform resource group"
  value       = module.resource_groups.resource_group_ids["${var.global_config.compact_prefix}-platform-rg-${var.global_config.environment}"]
}

output "integration_rg_id" {
  description = "Resource ID of the integration resource group"
  value       = module.resource_groups.resource_group_ids["${var.global_config.compact_prefix}-integration-rg-${var.global_config.environment}"]
}
```

#### Step 5: Configure Providers and Backend (`platform/terraform/global/providers.tf`)

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.3"
    }
  }
  required_version = ">= 1.12.2"
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  resource_provider_registrations = "none"
  subscription_id                 = "47a1099f-55eb-4047-97d4-4d8516f93798"
}

# Configure remote state backend in Azure Storage
terraform {
  backend "azurerm" {
    resource_group_name  = "vdc-cp-admin-cus-bootstrap-rg-dev"
    storage_account_name = "vdccpadmsacusdevtfbe"
    container_name       = "tfstatecpadmin"
    key                  = "dev-global.terraform.tfstate"
  }
}
```

#### Step 6: Environment Variables (`platform/terraform/envs/dev/global-vars/main.tfvars`)

```hcl
global_config = {
  prefix         = "vdc-cp-admin"
  compact_prefix = "vdccpadm"
  environment    = "dev"
  location       = "centralus"
  region_code    = "cus"
  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Project     = "Platform-Admin"
    CostCenter  = "Engineering"
  }
}
```

#### Step 7: Deployment Commands

```bash
# Navigate to the global directory
cd platform/terraform/global

# Initialize Terraform (downloads providers and module)
terraform init

# Validate configuration
terraform validate

# Plan with dev environment variables
terraform plan -var-file="../envs/dev/global-vars/main.tfvars"

# Apply with dev environment variables
terraform apply -var-file="../envs/dev/global-vars/main.tfvars"

# View outputs
terraform output
```

### Expected Results

When you run `terraform apply`, this configuration will create **8 resource groups**:

```
vdccpadm-container-rg-dev       (no lock - dev environment)
vdccpadm-web-rg-dev             (no lock - dev environment)
vdccpadm-security-rg-dev        (no lock - dev environment)
vdccpadm-data-rg-dev            (no lock - dev environment)
vdccpadm-monitoring-rg-dev      (no lock - dev environment)
vdccpadm-network-rg-dev         (no lock - dev environment)
vdccpadm-platform-rg-dev        (no lock - dev environment)
vdccpadm-integration-rg-dev     (no lock - dev environment)
```

For **production**, change the tfvars:
```hcl
global_config = {
  environment = "prod"  # This enables locks automatically
  # ... other config
}
```

This will create resource groups **with management locks** to prevent accidental deletion.

### Using Outputs in Other Modules

Reference the created resource groups in other Terraform configurations:

```hcl
# In another module (e.g., platform/terraform/storage/main.tf)
resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacct"
  resource_group_name      = data.terraform_remote_state.global.outputs.data_rg_id
  location                 = var.global_config.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
```

### Key Benefits of This Approach

1. ✅ **Centralized Configuration** - All resource groups defined in one place
2. ✅ **Environment-Specific Behavior** - Locks enabled for prod/stage, disabled for dev
3. ✅ **Consistent Naming** - Uses naming convention with prefix, type, and environment
4. ✅ **DRY Principle** - Loops through resource group types instead of repeating code
5. ✅ **Remote State** - Backend configured for team collaboration
6. ✅ **Version Pinning** - Uses specific module version for stability
7. ✅ **Easy Scaling** - Add new resource group types by updating the map
8. ✅ **Region Flexibility** - Easy to deploy to different Azure regions

## How It Works

1. **Resource Group Creation**: The module uses a `for_each` loop to iterate through the `resource_groups` list and creates a map with the resource group name as the key.

2. **Conditional Lock Creation**: Management locks are created only for resource groups where `locks = true`. The module filters the resource groups list and creates locks accordingly.

3. **Output Generation**: The module outputs maps that allow easy reference to created resources using their names as keys.

## Common Use Cases

### Production Environment with Locks

```hcl
module "production_rgs" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"

  resource_groups = [
    {
      name     = "rg-prod-app"
      location = "eastus"
      locks    = true  # Protect production resources
      tags = {
        Environment = "Production"
        CriticalData = "true"
      }
    }
  ]
}
```

### Development Environment without Locks

```hcl
module "development_rgs" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"

  resource_groups = [
    {
      name     = "rg-dev-app"
      location = "eastus"
      locks    = false  # Allow easy cleanup in dev
      tags = {
        Environment = "Development"
        AutoDelete  = "true"
      }
    }
  ]
}
```

### Multi-Region Deployment

```hcl
module "multi_region_rgs" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"

  resource_groups = [
    {
      name     = "rg-app-eastus"
      location = "eastus"
      locks    = true
      tags     = { Region = "Primary" }
    },
    {
      name     = "rg-app-westus"
      location = "westus"
      locks    = true
      tags     = { Region = "Secondary" }
    }
  ]
}
```

## Best Practices

1. **Always Use Locks in Production**: Set `locks = true` for production resource groups to prevent accidental deletion.

2. **Consistent Naming Convention**: Use a clear naming pattern like `rg-<app>-<env>-<region>` for easy identification.

3. **Tag Everything**: Use tags for cost tracking, environment identification, and ownership:
   ```hcl
   tags = {
     Environment = "Production"
     ManagedBy   = "Terraform"
     Owner       = "team@example.com"
     CostCenter  = "CC-1234"
     Application = "MyApp"
   }
   ```

4. **Pin Module Versions**: In production, always reference a specific version:
   ```hcl
   source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"
   ```

5. **Use Outputs for Resource Dependencies**: Reference created resource groups using module outputs rather than hardcoding names.

## Workflow

### Initial Deployment

```bash
# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

### Updating Resource Groups

```bash
# After modifying the configuration
terraform plan

# Apply changes
terraform apply
```

### Removing Resource Groups

⚠️ **Warning**: If `locks = true`, you must first remove the lock before destroying:

```bash
# Remove locks by setting locks = false, then apply
terraform apply

# Then destroy
terraform destroy
```

Or manually remove locks via Azure Portal/CLI before destroying.

## Troubleshooting

### Lock Prevents Deletion

**Issue**: Cannot delete resource group due to management lock.

**Solution**: 
```hcl
# Update configuration: set locks = false
resource_groups = [
  {
    name     = "rg-name"
    location = "eastus"
    locks    = false  # Changed from true
    tags     = {}
  }
]

# Apply to remove lock
terraform apply

# Then proceed with deletion
terraform destroy
```

### Name Already Exists

**Issue**: Resource group name already exists in subscription.

**Solution**: Azure resource group names must be unique within a subscription. Choose a different name or import the existing resource group.

### Location Not Available

**Issue**: Specified Azure region is not available.

**Solution**: Use `az account list-locations -o table` to see available regions for your subscription.

## Module Development & Release Process

This section explains how this module is developed, tagged, and released.

### Branching Strategy

- **`main`** - Stable, production-ready code
- **Feature branches** - Development work (e.g., `ranjit/modules`)

### Tagging Convention

Each module in this repository uses independent version tags:
- **Format**: `<module-name>/v<major>.<minor>.<patch>`
- **Example**: `resource-group/v1.0.0`

This allows each module to have its own version lifecycle.

### Release Workflow

#### 1. Development Phase
```bash
# Create or switch to a feature branch
git checkout -b ranjit/modules

# Make changes to the module
# Edit files in terraform/modules/resource-group/

# Commit changes
git add terraform/modules/resource-group/
git commit -m "Add resource group module with management locks"

# Push to remote
git push origin ranjit/modules
```

#### 2. Creating a Release Tag
```bash
# Ensure you're on the correct branch
git checkout ranjit/modules

# Create an annotated tag for the module version
git tag -a resource-group/v1.0.0 -m "Release resource-group module v1.0.0 - Initial release with Azure Resource Group and management lock support"

# Push the tag to remote
git push origin resource-group/v1.0.0
```

#### 3. Creating a Pull Request
```bash
# Create PR using GitHub CLI
gh pr create \
  --base main \
  --head ranjit/modules \
  --title "Add Azure Resource Group Module v1.0.0" \
  --label platform

# Or create PR via GitHub web interface
# https://github.com/ran130987wan/terraform-modules/compare/main...ranjit/modules
```

#### 4. Testing the Module

Before merging, test the module in your monorepo:

```hcl
# In your monorepo-pipeline repository
module "test_resource_groups" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"

  resource_groups = [
    {
      name     = "rg-test-validation"
      location = "eastus"
      locks    = false
      tags     = { Environment = "Test" }
    }
  ]
}
```

Run Terraform commands:
```bash
terraform init
terraform plan
terraform apply
# Verify resources created successfully
terraform destroy  # Clean up test resources
```

#### 5. Merging to Main

Once testing is complete:
1. Review the PR at https://github.com/ran130987wan/terraform-modules/pull/1
2. Ensure all changes are documented
3. Merge the PR to `main` branch
4. The tag `resource-group/v1.0.0` remains available for use

### Version Updates

When updating the module:

```bash
# Make changes on a feature branch
git checkout -b update/resource-group-v1.1.0

# After changes, create a new tag
git tag -a resource-group/v1.1.0 -m "Release resource-group module v1.1.0 - Added support for X"

# Push the new tag
git push origin resource-group/v1.1.0

# Create PR for review and merge
gh pr create --base main --head update/resource-group-v1.1.0 --label platform
```

### Checking Available Versions

To see all available versions of this module:

```bash
# List all tags for this module
git tag -l "resource-group/*"

# Output example:
# resource-group/v1.0.0
# resource-group/v1.1.0
# resource-group/v2.0.0
```

Or view on GitHub:
- Tags: https://github.com/ran130987wan/terraform-modules/tags
- Releases: https://github.com/ran130987wan/terraform-modules/releases

### Current Release Status

| Version | Status | Release Date | Notes |
|---------|--------|--------------|-------|
| `resource-group/v1.0.0` | ✅ Current | 2025-11-06 | Initial release with resource groups and management locks |

## Code Ownership & Access Control

This repository uses GitHub's CODEOWNERS feature to manage code ownership and permissions.

### CODEOWNERS Configuration

The `.github/CODEOWNERS` file defines ownership for different parts of the repository:

```
# Platform Team owns all Terraform modules
/terraform/                     @ran130987wan

# Specific module ownership
/terraform/modules/resource-group/      @ran130987wan
```

### Access Rules

- ✅ **Platform Engineers** - Full access to `/terraform/` directory
  - Can create, modify, and delete Terraform modules
  - Required as reviewers for PR approval
  - Responsible for module quality and standards

- ⚠️ **Other Contributors** - Restricted access to `/terraform/`
  - Can view and use modules
  - Cannot directly modify Terraform modules
  - Must submit PRs that require platform team approval

### PR Labels for Code Ownership

When creating pull requests, use these labels to identify the responsible developer:

| Label | Purpose | Usage |
|-------|---------|-------|
| `platform` | Indicates platform team changes | All terraform module changes |
| `codeowner: @ran130987wan` | Identifies the developer/owner | Track individual responsibility |

#### Creating a PR with Labels

```bash
# Create PR with platform and code owner labels
gh pr create \
  --base main \
  --head feature-branch \
  --title "Add new module" \
  --label platform \
  --label "codeowner: @ran130987wan"

# Or add labels after PR creation
gh pr edit <PR-NUMBER> --add-label platform
gh pr edit <PR-NUMBER> --add-label "codeowner: @ran130987wan"
```

### Automatic Review Requests

When a PR modifies files in the `/terraform/` directory:
1. GitHub automatically requests review from code owners
2. The PR cannot be merged without code owner approval (if branch protection is enabled)
3. Code owners receive notifications about changes

### Adding New Code Owners

As the team grows, update `.github/CODEOWNERS`:

```
# Example: Multiple code owners
/terraform/modules/resource-group/      @ran130987wan @platform-team

# Example: Team ownership
/terraform/modules/                     @organization/platform-engineers
```

### Best Practices for Code Ownership

1. **Always add appropriate labels** when creating PRs
2. **Tag the code owner** in PR descriptions for critical changes
3. **Wait for code owner approval** before merging
4. **Document changes** in commit messages for audit trails
5. **Test thoroughly** before requesting review from code owners

## Contributing

To contribute to this module:

1. Fork the repository: https://github.com/ran130987wan/terraform-modules
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Support

For issues or questions:
- **Repository**: https://github.com/ran130987wan/terraform-modules
- **Issues**: https://github.com/ran130987wan/terraform-modules/issues

## License

[Add your license information here]

## Authors

Maintained by the Platform Team

## Changelog

### resource-group/v1.0.0 (2025-11-06)

**Initial Release**

Features:
- ✅ Create multiple Azure Resource Groups from a single configuration
- ✅ Optional management locks with `CanNotDelete` level
- ✅ Flexible tagging support per resource group
- ✅ Output maps for resource group IDs and names
- ✅ Comprehensive documentation with usage examples

Resources:
- `azurerm_resource_group.this` - Creates resource groups
- `azurerm_management_lock.rg_lock` - Creates optional locks

Requirements:
- Terraform >= 1.12.0
- AzureRM Provider ~> 4.0

Documentation:
- Complete README with examples
- Usage instructions for monorepo integration
- Git tag-based versioning guide
- Troubleshooting section

Breaking Changes:
- None (initial release)

---

## Quick Start Guide

For users who want to get started quickly:

### Step 1: Add Module to Your Terraform Configuration

```hcl
module "resource_groups" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=resource-group/v1.0.0"

  resource_groups = [
    {
      name     = "rg-myapp-prod"
      location = "eastus"
      locks    = true
      tags     = { Environment = "Production" }
    }
  ]
}
```

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Plan and Apply

```bash
terraform plan
terraform apply
```

### Step 4: Reference Outputs

```hcl
output "my_rg_id" {
  value = module.resource_groups.resource_group_ids["rg-myapp-prod"]
}
```

---

**Need Help?** 
- 📖 Read the full documentation above
- 🐛 Report issues: https://github.com/ran130987wan/terraform-modules/issues
- 💬 Discussions: Contact the Platform Team
