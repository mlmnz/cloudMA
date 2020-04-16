
# General variables
variable "project_name" {
}

variable "region_name" {
  description = "The region that this terraform configuration will instanciate at."
  default     = "us-central1"
}

variable "zone_name" {
  description = "The zone that this terraform configuration will instanciate at."
  default     = "us-central1-a"
}



# Varibles for VM Instances
variable "machine_type" {
  description = "The size that this instance will be."
  default     = "f1-micro"
}

variable "image_name" {
  description = "The kind of VM this instance will become"
  default     = "cos-cloud/cos-stable"
}

# Varible for network
variable "docker_tag" {
  description = "Network tag used by VM instances"
  default     = "docker-tag"
}

variable "bucket_backend" {}
variable "bucket_docker"{}
variable "gcp_credentials" {}
variable "private_key" {}
variable "public_key" {}
variable "user" {}

