# Name of resources  
variable "prefix" {
  default = "myterraformproject"
}

variable "resource_group_location" {
  default     = "westus"
  description = "Location of the resource group."
}

variable "resource_vnet" {
  default     = "mytest-truenasvn"
  description = "uses a var for the name"
}