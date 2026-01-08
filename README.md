# Projet GCP CDN M1

Documentation générée automatiquement via la pipeline CI.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend_instances"></a> [backend\_instances](#module\_backend\_instances) | ./modules/compute | n/a |
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion | n/a |
| <a name="module_cdn"></a> [cdn](#module\_cdn) | ./modules/cdn | n/a |
| <a name="module_dns"></a> [dns](#module\_dns) | ./modules/dns | n/a |
| <a name="module_frontend_instances"></a> [frontend\_instances](#module\_frontend\_instances) | ./modules/compute | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./modules/load_balancer | n/a |
| <a name="module_vpc1_frontend"></a> [vpc1\_frontend](#module\_vpc1\_frontend) | ./modules/vpc | n/a |
| <a name="module_vpc2_backend"></a> [vpc2\_backend](#module\_vpc2\_backend) | ./modules/vpc | n/a |
| <a name="module_vpc_bastion"></a> [vpc\_bastion](#module\_vpc\_bastion) | ./modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_cpu_target"></a> [backend\_cpu\_target](#input\_backend\_cpu\_target) | Target CPU utilization for backend autoscaling (0.0 to 1.0) | `number` | `0.6` | no |
| <a name="input_backend_machine_type"></a> [backend\_machine\_type](#input\_backend\_machine\_type) | Machine type for backend instances | `string` | `"e2-medium"` | no |
| <a name="input_backend_max_replicas"></a> [backend\_max\_replicas](#input\_backend\_max\_replicas) | Maximum number of backend instances | `number` | `5` | no |
| <a name="input_backend_min_replicas"></a> [backend\_min\_replicas](#input\_backend\_min\_replicas) | Minimum number of backend instances | `number` | `1` | no |
| <a name="input_backend_source_image"></a> [backend\_source\_image](#input\_backend\_source\_image) | Source image for backend instances | `string` | `"debian-cloud/debian-11"` | no |
| <a name="input_backend_startup_script"></a> [backend\_startup\_script](#input\_backend\_startup\_script) | Startup script for backend instances | `string` | `"#!/bin/bash\napt-get update\napt-get install -y python3 python3-pip\necho \"Backend Server - $(hostname)\" > /tmp/backend.txt\n"` | no |
| <a name="input_bastion_machine_type"></a> [bastion\_machine\_type](#input\_bastion\_machine\_type) | Type de machine pour le bastion | `string` | `"e2-micro"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | Domaine principal | `string` | `"groupe1.pierremalherbe.com."` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | `"dev"` | no |
| <a name="input_frontend_cpu_target"></a> [frontend\_cpu\_target](#input\_frontend\_cpu\_target) | Target CPU utilization for frontend autoscaling (0.0 to 1.0) | `number` | `0.6` | no |
| <a name="input_frontend_machine_type"></a> [frontend\_machine\_type](#input\_frontend\_machine\_type) | Machine type for frontend instances | `string` | `"e2-medium"` | no |
| <a name="input_frontend_max_replicas"></a> [frontend\_max\_replicas](#input\_frontend\_max\_replicas) | Maximum number of frontend instances | `number` | `5` | no |
| <a name="input_frontend_min_replicas"></a> [frontend\_min\_replicas](#input\_frontend\_min\_replicas) | Minimum number of frontend instances | `number` | `1` | no |
| <a name="input_frontend_source_image"></a> [frontend\_source\_image](#input\_frontend\_source\_image) | Source image for frontend instances | `string` | `"debian-cloud/debian-11"` | no |
| <a name="input_frontend_startup_script"></a> [frontend\_startup\_script](#input\_frontend\_startup\_script) | Startup script for frontend instances | `string` | `"#!/bin/bash\napt-get update\napt-get install -y nginx\nsystemctl start nginx\nsystemctl enable nginx\necho \"<h1>Frontend Server - $(hostname)</h1>\" > /var/www/html/index.html\n"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region for resources | `string` | `"europe-west1"` | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service account email for instances (optional) | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP zone for resources | `string` | `"europe-west1-b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_autoscaler_id"></a> [backend\_autoscaler\_id](#output\_backend\_autoscaler\_id) | Backend autoscaler ID |
| <a name="output_backend_mig_id"></a> [backend\_mig\_id](#output\_backend\_mig\_id) | Backend Managed Instance Group ID |
| <a name="output_backend_mig_instance_group"></a> [backend\_mig\_instance\_group](#output\_backend\_mig\_instance\_group) | Backend instance group URL |
| <a name="output_frontend_autoscaler_id"></a> [frontend\_autoscaler\_id](#output\_frontend\_autoscaler\_id) | Frontend autoscaler ID |
| <a name="output_frontend_mig_id"></a> [frontend\_mig\_id](#output\_frontend\_mig\_id) | Frontend Managed Instance Group ID |
| <a name="output_frontend_mig_instance_group"></a> [frontend\_mig\_instance\_group](#output\_frontend\_mig\_instance\_group) | Frontend instance group URL |
| <a name="output_load_balancer_ip"></a> [load\_balancer\_ip](#output\_load\_balancer\_ip) | The external IP of the load balancer |
| <a name="output_vpc1_frontend_id"></a> [vpc1\_frontend\_id](#output\_vpc1\_frontend\_id) | VPC1 Frontend network ID |
| <a name="output_vpc1_frontend_subnet_cidr"></a> [vpc1\_frontend\_subnet\_cidr](#output\_vpc1\_frontend\_subnet\_cidr) | VPC1 Frontend subnet CIDR |
| <a name="output_vpc1_frontend_subnet_id"></a> [vpc1\_frontend\_subnet\_id](#output\_vpc1\_frontend\_subnet\_id) | VPC1 Frontend subnet ID |
| <a name="output_vpc2_backend_id"></a> [vpc2\_backend\_id](#output\_vpc2\_backend\_id) | VPC2 Backend network ID |
| <a name="output_vpc2_backend_subnet_cidr"></a> [vpc2\_backend\_subnet\_cidr](#output\_vpc2\_backend\_subnet\_cidr) | VPC2 Backend subnet CIDR |
| <a name="output_vpc2_backend_subnet_id"></a> [vpc2\_backend\_subnet\_id](#output\_vpc2\_backend\_subnet\_id) | VPC2 Backend subnet ID |
<!-- END_TF_DOCS -->
