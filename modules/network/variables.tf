# modules/network/variables.tf

variable "project_id" {
  description = "ID du projet GCP"
  type        = string
}

variable "network_name" {
  description = "Nom du réseau VPC"
  type        = string
  default = "vpc1"
}

variable "region" {
  description = "Région GCP"
  type        = string
  default     = "europe-west2"
}

variable "subnets" {
  description = "Map des sous-réseaux à créer"
  type = map(object({
    name = string
    cidr = string
  }))
}

variable "peer_network_self_link" {
  description = "Self link du réseau à peerer (optionnel)"
  type        = string
  default     = ""
}