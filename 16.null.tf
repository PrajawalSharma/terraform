resource "null_resource" "null_copy_ssh_key_to_bastion" {
  depends_on = [
    azurerm_linux_virtual_machine.bastion_host_linuxvm
  ]
  connection {
    type = "ssh"
    host = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("~/.ssh/id_rsa")
  }
  #file provisioiner which will upload my key
  provisioner "file" {
    source = "~/.ssh/id_rsa"
    destination = "/tmp/id_rsa"

  }
  provisioner "remote-exec" {
    inline = [
        "sudo chmod 400 /tmp/id_rsa"
    ]
  }
}

resource "null_resource" "null_connect_to_vm_from_bastion" {
  
  connection {
    type = "ssh"
    host = azurerm_linux_virtual_machine.example.public_ip_address
    user = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("~/.ssh/id_rsa")
  }
}
