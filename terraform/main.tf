
# Create new instance with Container OS 
resource "google_compute_instance" "docker-instance" {
    name         = "docker-instance"
    machine_type = var.machine_type

    tags = [var.docker_tag]

  boot_disk {
    initialize_params {
        image = var.image_name
    }
  }

  network_interface {
    network       = google_compute_network.docker-network.name
    access_config {
    }
  }


  #Post instance creation. Script
  provisioner "remote-exec" {
    connection {
      host= self.network_interface.0.access_config.0.nat_ip
    #   private_key = file(var.private_key)
    }  
    inline = [
      "mkdir /docker",
    ]
  }

   #Copies the script file docker-compose.yml
    provisioner "file" {
    source      = "../docker/"
    destination = "/docker"
  }

}



# Create a network for Docker/Kubernetes
resource "google_compute_network" "docker-network" {
  name = "docker-network"
}

resource "google_compute_firewall" "rules-docker" {
  name    = "docker-firewall-rule"
  network = google_compute_network.docker-network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "53"]
  }

  allow{
      protocol = "tcp"
      ports    = ["22"]
  }

  allow {
    protocol = "udp"
    ports    = ["53"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = [var.docker_tag]

}