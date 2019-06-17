# Indellient - Better Together Demo

## Requirements

- Azure account configured for an Azure Subscription
- Terraform 0.12
- Centos+Habitat+Docker Azure Images, see: [packer directory](./packer).

## Initializing Terraform

Ensure that a `backend.tfvars` file exists in the root directory, with the following keys:

```
storage_account_name = "[Your Azure Storage Account Name]"
resource_group_name  = "[Your Azure Resource Group]"
```

Terraform can now be initialized:

(within the `terraform` directory)

```
terraform init -backend-config=terraform.tfvars
```

## Credits

The directory [habitat/sample-node-app](habitat/sample-node-app) has been copied from https://github.com/habitat-sh/sample-node-app. Only the field `pkg_origin` in the package's [plan.sh](habitat/sample-node-app/habitat/plan.sh) file has been modified.
