resource "oci_core_instance" "demo-box" {
  availability_domain = "MoMM:EU-FRANKFURT-1-AD-1"
  compartment_id      = var.demo_compartment_ocid
  shape               = "VM.Standard.E2.1.Micro"
  display_name        = "Demo Box"

  agent_config {
    is_monitoring_disabled = false
  }

  create_vnic_details {
    assign_public_ip = true
    display_name     = "Primary VNIC"
    hostname_label   = "demo-box"
    subnet_id        = oci_core_subnet.demo-box.id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_key
  }

  source_details {
    source_id   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaal4cnqdf7ngwp66rjzvekzkgpjpmiwlv3edajlbdyexyupbv5dsya"
    source_type = "image"
  }
}

output "Demo-Box-Public-IP" {
  value = [oci_core_instance.demo-box.public_ip]
}