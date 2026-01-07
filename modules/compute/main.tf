resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnet_id
    network_ip = var.internal_ip
    access_config {
      # Include this section to give the VM an external ip address
    }
  }

  metadata = {
    ssh-keys = var.ssh_keys
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "Instance Test" > /var/www/html/index.html
  EOF
}
