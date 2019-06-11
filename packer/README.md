# Packer Configuration

This section is used to create an Azure VHD from Centos 7.6 with Chef Habitat installed.

Packer must be [authorized to use Azure](https://www.packer.io/docs/builders/azure-setup.html) in order to create the VHD in question. Once an Azure Subscription, its corresponding policies and Resource Group information is available, the following environment variables must be set:

- ARM_CLIENT_ID
- ARM_CLIENT_SECRET
- ARM_SUBSCRIPTION_ID
- ARM_TENANT_ID
- ARM_SSH_PASS (generate this using `openssl rand -base64 32`)
- ARM_RESOURCE_GROUP_NAME
- HAB_BLDR_URL (the URL of the [Habitat Builder](https://www.habitat.sh/docs/using-builder/) which the VHD's Habitat supervisor service will be configured to use)
