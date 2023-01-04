locals {
  #the purpose of local values is to do concatination of multiple varaiblename 
  owners = var.business_division
  environment = var.environment
  #3now we want to concatinate above mentioned varaible togetherasda
  resource_name_prefix = "${var.business_division}-${var.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
}