# Create a RG
resource "azurerm_resource_group" "mytestrg" {
  name     = "${var.prefix}-rg"
  location = var.resource_group_location
#Optional
  tags = {
    environment = "Terraform"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "mytestvnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.mytestrg.location}"
  resource_group_name = "${azurerm_resource_group.mytestrg.name}"

  tags = {
    environment = "Terraform"
  }
}

# Create a subnet
resource "azurerm_subnet" "mytestsubnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = "${azurerm_resource_group.mytestrg.name}"
  virtual_network_name = "${azurerm_virtual_network.mytestvnet.name}"
  address_prefix       = "10.0.1.0/24"

}

# Create a NIC
resource "azurerm_network_interface" "mytestnic" {
  name                = "${var.prefix}-nic"
  location            = "${azurerm_resource_group.mytestrg.location}"
  resource_group_name = "${azurerm_resource_group.mytestrg.name}"

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = "${azurerm_subnet.mytestsubnet.id}"
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Terraform"
  }
}

resource "azurerm_virtual_machine" "mytestvm" {
  name                  = "${var.prefix}-vm"
  location              = "${azurerm_resource_group.mytestrg.location}"
  resource_group_name   = "${azurerm_resource_group.mytestrg.name}"
  network_interface_ids = ["${azurerm_network_interface.mytestnic.id}"]
  vm_size               = "Standard_DS1_v2"
    
  # Required field
  storage_image_reference {
    publisher = "ixsystems"
    offer     = "truenas"
    sku       = "11.3-U5"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-vm"
    admin_username = ""
    admin_password = ""
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  
}
