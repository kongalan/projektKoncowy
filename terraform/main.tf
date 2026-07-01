locals {
  nodes = {
    k8s-master = {
      vmid = 201
      ip   = "192.168.137.10"
    }

    k8s-worker1 = {
      vmid = 202
      ip   = "192.168.137.11"
    }

    k8s-worker2 = {
      vmid = 203
      ip   = "192.168.137.12"
    }
  }
}

resource "proxmox_virtual_environment_vm" "k8s" {
  for_each = local.nodes

  name      = each.key
  node_name = "proxmox"
  vm_id     = each.value.vmid

  clone {
    vm_id = 9000
    full  = true
  }

  started = true

  cpu {
    cores   = 2
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = 2048
  }

  agent {
    enabled = false
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 30
    iothread     = true
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = "192.168.137.1"
      }
    }

    user_account {
      username = "ubuntu"
      keys     = [trimspace(var.ssh_key)]
    }

    dns {
      servers = ["1.1.1.1", "8.8.8.8"]
    }
  }


  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }
}