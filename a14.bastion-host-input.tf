variable "bastion_service_subnet_name" {
type = string
  default = "AzureBastionSubnet"
}
variable "bastion_service_address_prefixes" {
     type = list(string)
  default = ["10.0.101.0/27"]
}
