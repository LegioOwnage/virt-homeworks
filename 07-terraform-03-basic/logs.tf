terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/MWiJOLJopTXolG2IZdSGXBb8LMqZBznu5K+uoPpprobi1NBOf1Wyj+y1dstIEMlpQUyceyqAsqFqjwZ9dUmDDRtJudZe3n2N3xdTNRKHzqrDNnooOaXKcY0mKClo25cO3isx4vIka+Dk4i0yGm1EQ5ERkyxKR8FFqW5yPnD0zCv6+iE+C++U3b4Fo1g8mozZpuaom10B3MFoKIk+F5lnpvXrR0RpnUQHnSEl8XhAzfXbyv7uK5wZxnoslJlZ3ntjGg5/D1JHxkEdxCVSwvdFUJHbp+PB5EKehEZFcwDZx+OYQB417hJ80wJnxKx/EZXsOAZNiBwJw2xQGgH16g8gGa08s+b5v0TIiz5u3eFIxps3N1PfV5GW7BaweWQi+KlbpkWQ22FATr4olGL4KgbV0vSV2trCrymVPJ21+R/DSRGEQAyYPg3uhEtVwOhGzjRoP4X2oimdl27lYEk4vlZcBAobcWvwXAIvqVifvTb93G3b8AIfdFLqQQTOW0mZUec= user@user
            EOT
        }
      + name                      = "vm-1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "var.ubuntu"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = "yandex_vpc_subnet.default.id"
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = "yandex_vpc_network.default.id"
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions in workspace "stage"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.default: Creating...
yandex_vpc_subnet.default: Creating...
yandex_compute_instance.vm[0]: Creating...
yandex_vpc_network.default: Creation complete after 1s [id=enpgf1bv4k0u86t5uake]
╷
│ Error: Error create 'boot_disk' object of api request: Error on retrieve image properties: server-request-id = 4dd3613a-901c-44cd-ba7c-29b6286820a7 server-trace-id = cb4eeeea794ea88f:cd38981597f56796:cb4eeeea794ea88f:1 client-request-id = 921e491d-6e39-46c7-babc-6484eb61c9db client-trace-id = 3ef58ad8-c7b5-4e18-a4d6-8b5b2c25dc7a rpc error: code = InvalidArgument desc = invalid image id 'var.ubuntu'
│ 
│   with yandex_compute_instance.vm[0],
│   on main.tf line 44, in resource "yandex_compute_instance" "vm":
│   44: resource "yandex_compute_instance" "vm" {
│ 
╵
╷
│ Error: Error while requesting API to create subnet: server-request-id = acb19d31-5b1d-4867-ba13-bddffc7932e1 server-trace-id = 604b549793f987cc:22e7e65f0ae5b531:604b549793f987cc:1 client-request-id = 075f8dc6-a825-440a-afd6-893a1a0ed3dc client-trace-id = 3ef58ad8-c7b5-4e18-a4d6-8b5b2c25dc7a rpc error: code = NotFound desc = Network yandex_vpc_network.default.id not found
│ 
│   with yandex_vpc_subnet.default,
│   on main.tf line 74, in resource "yandex_vpc_subnet" "default":
│   74:   resource "yandex_vpc_subnet" "default" {
│ 
╵
