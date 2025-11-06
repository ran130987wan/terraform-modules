# Terraform Modules Repository

A centralized repository for reusable Terraform modules for Azure infrastructure management.

## Overview

This repository contains production-ready Terraform modules that can be used across multiple projects. Each module is independently versioned using Git tags and follows consistent standards for quality and documentation.

## Repository Structure

```
terraform-modules/
├── .github/
│   └── CODEOWNERS              # Defines code ownership
├── terraform/
│   └── modules/
│       └── resource-group/     # Azure Resource Group module
│           ├── main.tf
│           ├── variables.tf
│           ├── outputs.tf
│           ├── versions.tf
│           └── README.md
└── README.md                   # This file
```

## Available Modules

| Module | Version | Description | Documentation |
|--------|---------|-------------|---------------|
| **resource-group** | v1.0.0 | Create Azure Resource Groups with optional management locks | [README](terraform/modules/resource-group/README.md) |

## Quick Start

### Using Modules in Your Project

Reference modules using Git source with specific version tags:

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

### Version Tags

Each module uses independent version tags:
- Format: `<module-name>/v<version>`
- Example: `resource-group/v1.0.0`

View all available tags:
```bash
git tag -l "resource-group/*"
```

## Code Ownership

This repository uses **CODEOWNERS** to manage access control and ensure quality standards.

### Access Control

#### Platform Engineers (@ran130987wan)
- ✅ Full access to `/terraform/` directory
- ✅ Can create, modify, and delete modules
- ✅ Required reviewers for all terraform changes
- ✅ Responsible for module quality and standards

#### Other Contributors
- ✅ Can view and use modules
- ⚠️ Cannot directly modify `/terraform/` directory
- ⚠️ Must submit PRs reviewed by platform team

### CODEOWNERS File

Location: `.github/CODEOWNERS`

```
# Platform Team owns all Terraform modules
/terraform/                     @ran130987wan

# Specific module ownership
/terraform/modules/resource-group/      @ran130987wan
```

## Contributing

### For Platform Engineers

1. **Create a feature branch**
   ```bash
   git checkout -b feature/new-module
   ```

2. **Develop your module** in `terraform/modules/<module-name>/`

3. **Create a version tag**
   ```bash
   git tag -a <module-name>/v1.0.0 -m "Initial release of <module-name>"
   git push origin <module-name>/v1.0.0
   ```

4. **Create a pull request** with appropriate labels
   ```bash
   gh pr create \
     --base main \
     --head feature/new-module \
     --title "Add <module-name> module v1.0.0" \
     --label platform \
     --label "codeowner: @ran130987wan"
   ```

5. **Test the module** in a separate project before merging

6. **Merge to main** after approval and testing

### PR Labels

Always include these labels on pull requests:

| Label | Required | Purpose |
|-------|----------|---------|
| `platform` | ✅ Yes | Identifies platform team changes |
| `codeowner: @<username>` | ✅ Yes | Tracks developer responsibility |

### Branch Protection Rules (Recommended)

Enable these settings on `main` branch:
- ✅ Require pull request reviews (1 approval)
- ✅ Require review from code owners
- ✅ Require status checks to pass
- ✅ Require conversation resolution before merging
- ✅ Do not allow bypassing the above settings

## Module Standards

All modules must include:

1. ✅ **main.tf** - Resource definitions
2. ✅ **variables.tf** - Input variables with descriptions
3. ✅ **outputs.tf** - Output values with descriptions
4. ✅ **versions.tf** - Terraform and provider versions
5. ✅ **README.md** - Comprehensive documentation with:
   - Overview and features
   - Usage examples
   - Input variables documentation
   - Output values documentation
   - Requirements
   - Examples for different scenarios

## Module Versioning

### Version Tags

- Follow semantic versioning: `v<major>.<minor>.<patch>`
- Tag format: `<module-name>/v<version>`
- Create annotated tags with release notes

### Version Increments

- **Major (v2.0.0)** - Breaking changes
- **Minor (v1.1.0)** - New features, backward compatible
- **Patch (v1.0.1)** - Bug fixes, backward compatible

Example:
```bash
# Create and push a new version
git tag -a resource-group/v1.1.0 -m "Add support for custom lock notes"
git push origin resource-group/v1.1.0
```

## Testing Modules

Before merging, test modules in a separate project:

```hcl
# Test configuration
module "test" {
  source = "git::https://github.com/ran130987wan/terraform-modules.git//terraform/modules/<module-name>?ref=<branch-name>"
  
  # Test configuration
}
```

```bash
terraform init
terraform plan
terraform apply
# Verify resources
terraform destroy
```

## Support & Issues

- **Issues**: https://github.com/ran130987wan/terraform-modules/issues
- **Pull Requests**: https://github.com/ran130987wan/terraform-modules/pulls
- **Tags**: https://github.com/ran130987wan/terraform-modules/tags

## License

[Add your license information here]

## Maintainers

- **Platform Team**: @ran130987wan
- **Code Owners**: See [CODEOWNERS](.github/CODEOWNERS)

---

**Last Updated**: 2025-11-06