terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "netologybackend"
    region     = "ru-central1"
    key        = "[terraform.workspace]/terraform.tfstate"
    access_key = "YCAJEFC6Yrm4W7jaYDi9shG6G"
    secret_key = "YCNlyDXD1rLMWc2T3QIH8KU7aaTo9CZDHFZqQQf7"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  #token = var.oauth_token
  service_account_key_file = "key.json"
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
  name = local.yandex_instance_name_map[terraform.workspace]

  count = local.vm_instance_count_map[terraform.workspace]

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd86cpunl4kkspv0u25a"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
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
    network_id     = "${yandex_vpc_network.default.id}"
    v4_cidr_blocks = ["192.168.10.0/24"]
  }

















## for each example
#
#variable "hostnames" {
#    default = {
#        "prod" = {
#            "name" = "prod",
#            "platform_id" = "standard-v1",
#            #"os" = "fd87va5cc00gaq2f5qfb",
#            "zone" = "ru-central1-a"
#            #"folder_id" = var.yandex_folder_id
#        },
#        "stage" = {
#            "name" = "stage",
#            "platform_id" = "standard-v1",
#            #"os" = "fd87va5cc00gaq2f5qfb",
#            "zone" = "ru-central1-a",
#            #"folder_id" = var.yandex_folder_id
#        }
#    }
#}
#
#resource "yandex_compute_instance" "default" {
#    for_each = var.hostnames
#    name         = each.value.name
#    zone         = each.value.zone
#
#    boot_disk {
#        initialize_params {
#            image_id = "fd87uq4tagjupcnm376a"
#        }
#    }
#
#    network_interface {
#    subnet_id = "yandex_vpc_subnet.default.id"
#    nat       = true
#    }
#
#  resources {
#    cores  = 2
#    memory = 2
#  }
#    metadata = {
#    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
#  }
#}
#
#  resource "yandex_vpc_network" "default" {
#    name = "net"
#  }
#
#  resource "yandex_vpc_subnet" "default" {
#    name           = "subnet"
#    zone           = "ru-central1-a"
#    network_id     = "yandex_vpc_network.default.id"
#    v4_cidr_blocks = ["10.128.0.0/24"]
#  }
#
#
#
#resource "yandex_compute_instance" "vm" {
#  for_each = {
#    "prod"  = { vm_size = "blabla", zone = "ru-central1-a" }
#    "stage" = { vm_size = "blabla", zone = "ru-central1-a" }
#  }
#  name     = each.key
#  resources {
#    cores  = 2
#    memory = 2
#  }
#  boot_disk {
#    initialize_params {
#      image_id = "fd87uq4tagjupcnm376a"
#    }
#  }
#
#  network_interface {
#    subnet_id = "yandex_vpc_subnet.default.id"
#    nat       = true
#  }
#
#  #  resources "yandex_vpc_subnet" "default" {
#  #    name           = "subnet"
#  #    zone           = "ru-central1-a"
#  #    network_id     = "yandex_vpc_network.default.id"
#  #    v4_cidr_blocks = ["10.128.0.0/24"]
#  #    metadata = {
#  #    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
#  #  }
#}