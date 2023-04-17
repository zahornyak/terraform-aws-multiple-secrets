# AWS Secrets manager multiple secrets creation
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/zahornyak/terraform-aws-multiple-secrets)

Terraform module that allows for the creation of multiple secrets and significantly simplifies the process of creating them.
Especially comfortable with Terragrunt.

secret rotation temporary disabled

## Usage

```hcl
module "secrets" {
  source  = "zahornyak/multiple-secrets/aws"

  secrets = {
    my_secret = {
      name                    = "my_secret_name"
      recovery_window_in_days = 10
      secret_string           = "example"
    }
    your_secret = {
      name                    = "your_secret_name"
      recovery_window_in_days = 10
      secret_binary           = "sha sjhgdhkajwndask"
    }
    foo = {
      name                    = "bar"
      recovery_window_in_days = 0
      secret_string           = "foo-bar"
    }
  }
}
```

### Unlocked secrets

```hcl
module "secrets" {
  source  = "zahornyak/multiple-secrets/aws"

  secrets = {
    my_secret = {
      name                    = "my_secret_name"
      recovery_window_in_days = 10
      secret_string           = "example"
    }
    your_secret = {
      name                    = "your_secret_name"
      recovery_window_in_days = 10
      secret_binary           = "sha sjhgdhkajwndask"
    }
  }

  # Terraform wont change secret string and binary value
  unlocked = true
}
```


### Dynamically unlocked secrets

```hcl
module "secrets" {
  source  = "zahornyak/multiple-secrets/aws"

  secrets = {
    my_secret = {
      name                    = "my_secret_name"
      recovery_window_in_days = 10
      secret_string           = "example"
    }
    your_secret = {
      name                    = "your_secret_name"
      recovery_window_in_days = 10
      secret_binary           = "sha sjhgdhkajwndask"
      unlocked                = true   # Terraform wont change secret string and binary value for only that secret
    }
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.37 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.this_unlocked](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Specifies the number of days for recovery window | `number` | `30` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Map of secrets to keep in AWS Secrets Manager | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a tags | `any` | `{}` | no |
| <a name="input_unlocked"></a> [unlocked](#input\_unlocked) | if true - sets the ignore lifecycle policy and disable terraform managing the version of the resource | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_arns"></a> [secret\_arns](#output\_secret\_arns) | Secrets arns map |
| <a name="output_secret_ids"></a> [secret\_ids](#output\_secret\_ids) | Secret ids map |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->