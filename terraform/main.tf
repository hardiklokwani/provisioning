terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
        }
    }
}

provider "proxmox" {
    pm_api_url          = "https://192.168.178.200:8006///api2/json"
    pm_api_token_id     = "yourtokenid"
    pm_api_token_secret = "yourtokensecret"
    pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "k3s-worker02" {        #select instance name
    name                = "k3s-worker02"           #select instance name
    target_node         = "hardik"                 #your proxmox node name
    clone               = "hardik"                 #your proxmox clone template name
    full_clone          = true
    cores               = 4
    memory              = 2048

    disk {
        size            = "128G"
        type            = "scsi"
        storage         = "local-lvm"
        discard         = "on"
    }

    network {
        model     = "virtio"
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
    }

}
