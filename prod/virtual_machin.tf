module "nic" {
    source = "git::https://github.com/shivakpkp/terraform-azure-modules.git//network/terraform-azure-network-interface?ref=prod"
    network_interfaces = {
        "master-nic" = {
            name                = "nic-aks-master"
            resource_group_name = local.resource_group_name
            location            = var.location
            ip_configuration = [{
                name                          = "ipconfig1"
                subnet_id                     = module.subnet.subnet_ids["vm-subnet"]
                private_ip_address_allocation = "Dynamic"
            }]
        }
        "worker-nic-01" = {
            name                = "nic-aks-worker-01"
            resource_group_name = local.resource_group_name
            location            = var.location
            ip_configuration = [{
                name                          = "ipconfig1"
                subnet_id                     = module.subnet.subnet_ids["vm-subnet"]
                private_ip_address_allocation = "Dynamic"
            }]
        }
        "worker-nic-02" = {
            name                = "nic-aks-worker-02"
            resource_group_name = local.resource_group_name
            location            = var.location
            ip_configuration = [{
                name                          = "ipconfig1"
                subnet_id                     = module.subnet.subnet_ids["vm-subnet"]
                private_ip_address_allocation = "Dynamic"
            }]
        }
    }
    tags = var.tags
}

module "vm" {
  source = "git::https://github.com/shivakpkp/terraform-azure-modules.git//compute/terraform-azure-windows-vm?ref=prod"
  admin_passwords = var.admin_password
  windows_virtual_machines = {
    master-vm = {
      name                = "vm-master"
      computer_name      = "vm-master"
      resource_group_name = local.resource_group_name
      location            = var.location
      size             = "Standard_B2s"
      admin_username      = "adminuser"
      network_interface_ids = [
        module.nic.network_interface_ids["master-nic"]
      ]
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2019-Datacenter"
        version   = "latest"
      }
    }
    worker-vm-01 = {
      name                = "vm-worker-01"
      computer_name      = "vm-worker-01"
      resource_group_name = local.resource_group_name
      location            = var.location
      size             = "Standard_B2s"
      admin_username      = "adminuser"
      network_interface_ids = [
        module.nic.network_interface_ids["worker-nic-01"]
      ]
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2019-Datacenter"
        version   = "latest"
      }
    }
    worker-vm-02 = {
      name                = "vm-worker-02"
      computer_name      = "vm-worker-02"
      resource_group_name = local.resource_group_name
      location            = var.location
      size             = "Standard_B2s"
      admin_username      = "adminuser"
      network_interface_ids = [
        module.nic.network_interface_ids["worker-nic-02"]
      ]
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2019-Datacenter"
        version   = "latest"
      }
    }
  }
}