terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.110"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://192.168.137.2:8006/"
  api_token = "terraform@pve!terraform=${var.pm_token_secret}"
  insecure  = true
}