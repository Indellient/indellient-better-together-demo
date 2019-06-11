# HashiCorp/Chef/Indellient Better Together Demo

## Requirements

- Azure account configured for an Azure Subscription
- Terraform 0.12
- Centos+Habitat Azure VHD's, see: [packer directory](./packer).

## Initializing Terraform

Ensure that a `backend.tfvars` file exists in the root directory, with the following keys:

```
storage_account_name = "[Your Azure Storage Account Name]"
resource_group_name  = "[Your Azure Resource Group]"
```

Terraform can now be initialized:

```
terraform init -backend-config=backend.tfvars
```
