variable "zone" {
  description = "The zone to deploy the instance in"
  type        = string
}

variable "instance_name" {
  description = "The name of the compute instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to attach to"
  type        = string
}

variable "internal_ip" {
  description = "The internal IP to assign"
  type        = string
}

variable "ssh_keys" {
  description = "Public SSH keys"
  type        = string
}
