variable "region" {
  description = "The region to deploy resources in"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_range" {
  description = "The CIDR range of the subnet"
  type        = string
}
