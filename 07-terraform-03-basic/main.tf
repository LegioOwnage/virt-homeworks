terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token = var.oauth_token
  cloud_id = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone = "ru-central1-a"
}

locals {
  yandex_instance_name_map = {
    stage = "vm-1"
    prod = "vm-2"
  }
}

locals {
  vm_instance_count_map = {
    stage = 1
    prod  = 2
  }
}

resource "yandex_compute_instance" "vm" {
   resources {
    cores  = 2
    memory = 2
  }

  name = local.yandex_instance_name_map[terraform.workspace]

  count = local.vm_instance_count_map[terraform.workspace]

  boot_disk {
    initialize_params {
      image_id = "var.ubuntu"
    }
  }

  network_interface {
    subnet_id = "yandex_vpc_subnet.default.id"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

  resource "yandex_vpc_network" "default" {
    name = "net"
  }

  resource "yandex_vpc_subnet" "default" {
    name           = "subnet"
    zone           = "ru-central1-a"
    network_id     = "yandex_vpc_network.default.id"
    v4_cidr_blocks = ["192.168.10.0/24"]
  }
