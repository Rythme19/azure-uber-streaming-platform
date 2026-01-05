# ===============================
# Kafka NIC
# ===============================
resource "azurerm_network_interface" "kafka_nic" {
  name                = "kafka-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# ===============================
# Kafka VM
# ===============================
resource "azurerm_linux_virtual_machine" "kafka_vm" {
  name                = "kafka-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size = "Standard_D2s_v3"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.kafka_nic.id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("/Users/user/.ssh/id_rsa.pub") # Assurez-vous que vous avez une clé SSH
  }

  # Script pour installer Docker + Kafka automatiquement
  custom_data = filebase64("${path.module}/install_kafka.sh")

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
