variable "location" {
  type    = string
  default = "canadacentral"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}

   