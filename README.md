# Terraform Workspaces

> **Companion lab** for the Medium article [**Managing Environments with Terraform Workspaces CLI**](https://blog.devops.dev/managing-environments-with-terraform-workspaces-cli-d5f114f94d29).
> Part of my Terraform fundamentals series — more on [Medium](https://medium.com/@rafael_muller).

---

## What you'll learn

How to manage multiple environments (dev, uat, prd) from a single Terraform codebase using workspaces — avoiding the classic "copy-paste directories per environment" antipattern.

## Architecture

```
┌──────────────────┐       ┌────────────────────────────────┐
│   Terraform      │       │   AWS (us-east-1)              │
│   workspaces     │       │                                │
│   ├─ default     │ ────► │   dev-vm01   → t3.small        │
│   ├─ dev         │ ────► │   uat-vm01   → t3.medium       │
│   ├─ uat         │ ────► │   prd-vm01   → t3.large        │
│   └─ prd         │       │                                │
└──────────────────┘       └────────────────────────────────┘
```

Each workspace gets its own state file and provisions a differently-sized instance, all from the same code.

## What's inside

| File | Purpose |
|------|---------|
| `provider.tf` | Declares the AWS provider and region |
| `variables.tf` | Defines the `region` input variable |
| `locals.tf` | Per-workspace config (instance name, type, environment tag) |
| `main.tf` | Creates the EC2 instance, sizing it from `local.env[terraform.workspace]` |
| `backend.tf` | Configures local state backend |

## Prerequisites

- Terraform ≥ 1.5
- AWS CLI configured (`aws configure`) with a `default` profile
- An AWS account

## Quick start

```bash
# Initialize providers
terraform init

# Create and switch to the dev workspace
terraform workspace new dev
terraform apply

# Create and switch to prd (uses a larger instance size)
terraform workspace new prd
terraform apply

# List all workspaces
terraform workspace list

# Switch back to dev
terraform workspace select dev
```

Each workspace has its own independent state — resources in `dev` are untouched when you operate on `prd`.

## Cleanup

Destroy resources per workspace, then delete the workspace itself:

```bash
terraform workspace select dev
terraform destroy

terraform workspace select prd
terraform destroy

# Return to default before deleting
terraform workspace select default
terraform workspace delete dev
terraform workspace delete prd
```

## Key concepts

- **Workspaces** — named, isolated state instances sharing the same code (`terraform workspace new/select/list/delete`)
- **`terraform.workspace`** — built-in variable giving the current workspace name, used here to pick the right `locals` block
- **Locals map pattern** — clean way to parameterize per-environment config without exploding `.tfvars` files
- **DRY infrastructure** — one codebase, N environments, versioned and diffable together

## Trade-offs to know

Workspaces are lightweight but **share the same backend configuration**. For strong isolation (different AWS accounts, different state backends), prefer a **Terragrunt / directory-per-env** approach. Workspaces shine for similar environments in the same account.

## Series

Part of my Terraform fundamentals series:

- **Previous:** [Creating Your First Instance with Terraform](https://github.com/rtmuller/terraform-basics)
- **Next:** [Using Multiple Providers](https://github.com/rtmuller/terraform-multi-providers)

All articles on [Medium](https://medium.com/@rafael_muller).
