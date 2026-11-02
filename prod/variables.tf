variable "location" {
  type = string
  default = "canadacentral"
}

variable "resource_group_name" {
  type = string
  default = "rg-kubernetes-${local.env}"
}

   