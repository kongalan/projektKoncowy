locals {
  nodes = {
    k8s-master = {
      vmid = 201
      ip   = "192.168.56.105"
    }

    k8s-worker1 = {
      vmid = 202
      ip   = "192.168.56.106"
    }

    k8s-worker2 = {
      vmid = 203
      ip   = "192.168.56.107"
    }
  }
}

resource "proxmox_vm_qemu" "k8s" {

  for_each = local.nodes

  name        = each.key
  target_node = "pve"
  vmid        = each.value.vmid

  clone       = "ubuntu2404-template"
  full_clone  = true

  agent       = 1
  os_type     = "cloud-init"

  cores       = 2
  sockets     = 1
  cpu         = "host"

  memory      = 2048

  scsihw      = "virtio-scsi-single"

  disks {
  scsi {
    scsi0 {
      disk {
        size    = 30
        storage = "local-lvm"
            }
        }
    }
  }

  network {    
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=${each.value.ip}/24,gw=192.168.56.1"

  ciuser  = "ubuntu"

  sshkeys = var.ssh_key

  nameserver = "1.1.1.1"
}