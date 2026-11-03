module "network" {
  source = "git::https://github.com/shivakpkp/terraform-azure-modules.git//network/terraform-azure-vnirtual-network?ref=prod"

  location = var.location

  tags = {
    Environment = "${local.env}"
    ManagedBy   = "Terraform"
  }

  virtual_network = {
    application = {
      name                = "vnet-ks"
      resource_group_name = local.resource_group_name
      address_space       = ["10.20.0.0/16"]

      tags = {
        Workload = "Kubernetes"
      }
    }
  }
}

