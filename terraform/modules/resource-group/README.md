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

## Usage

### From Your Monorepo (ran130987wan/monorepo-pipeline)

To use this module from your calling repository, reference it as a Git source:

```hcl
module "resource_groups" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=main"

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

### Referencing Specific Versions

For production use, always pin to a specific tag or commit:

```hcl
# Using a Git tag
source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=v1.0.0"

# Using a specific commit
source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=abc123def"

# Using a branch (for testing only)
source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=feature-branch"
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

## Complete Example

Here's a complete example for your monorepo:

```hcl
# main.tf in your monorepo-pipeline repository

terraform {
  required_version = ">= 1.12.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "resource_groups" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=main"

  resource_groups = [
    {
      name     = "rg-frontend-prod-eastus"
      location = "eastus"
      locks    = true
      tags = {
        Environment = "Production"
        Component   = "Frontend"
        ManagedBy   = "Terraform"
      }
    },
    {
      name     = "rg-backend-prod-eastus"
      location = "eastus"
      locks    = true
      tags = {
        Environment = "Production"
        Component   = "Backend"
        ManagedBy   = "Terraform"
      }
    },
    {
      name     = "rg-shared-dev-westus"
      location = "westus"
      locks    = false
      tags = {
        Environment = "Development"
        Component   = "Shared"
        ManagedBy   = "Terraform"
      }
    }
  ]
}

# Use outputs in other resources
output "rg_ids" {
  value = module.resource_groups.resource_group_ids
}

output "rg_names" {
  value = module.resource_groups.resource_group_names
}
```

## How It Works

1. **Resource Group Creation**: The module uses a `for_each` loop to iterate through the `resource_groups` list and creates a map with the resource group name as the key.

2. **Conditional Lock Creation**: Management locks are created only for resource groups where `locks = true`. The module filters the resource groups list and creates locks accordingly.

3. **Output Generation**: The module outputs maps that allow easy reference to created resources using their names as keys.

## Common Use Cases

### Production Environment with Locks

```hcl
module "production_rgs" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=main"

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
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=main"

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
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=main"

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
   source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/resource-group?ref=v1.0.0"
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

### Version 1.0.0
- Initial release
- Support for multiple resource groups
- Optional management locks
- Tag support
- Output maps for IDs and names
