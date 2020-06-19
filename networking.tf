resource "oci_core_vcn" "demo-box" {
  cidr_block     = "172.16.0.0/16"
  compartment_id = var.demo_compartment_ocid
  dns_label      = "demo"
  display_name   = "Demo Box"
}

resource "oci_core_internet_gateway" "demo-box" {
  compartment_id = var.demo_compartment_ocid
  display_name   = "Demo Box"
  vcn_id         = oci_core_vcn.demo-box.id
  enabled        = true
}

resource "oci_core_route_table" "demo-box" {
  compartment_id = var.demo_compartment_ocid
  vcn_id         = oci_core_vcn.demo-box.id
  display_name   = "Demo Box"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.demo-box.id
  }
}

resource "oci_core_security_list" "demo-box-incoming" {
  display_name   = "Incoming traffic for Demo Box"
  compartment_id = var.demo_compartment_ocid
  vcn_id         = oci_core_vcn.demo-box.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    icmp_options {
      type = 0
    }

    protocol = 1
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    icmp_options {
      type = 3
      code = 4
    }

    protocol = 1
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    icmp_options {
      type = 8
    }

    protocol = 1
    source   = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_subnet" "demo-box" {
  cidr_block        = oci_core_vcn.demo-box.cidr_block
  compartment_id    = var.demo_compartment_ocid
  vcn_id            = oci_core_vcn.demo-box.id
  route_table_id    = oci_core_route_table.demo-box.id

  display_name      = "Demo Box"
  dns_label         = "demo"
  security_list_ids = [
      oci_core_security_list.demo-box-incoming.id
  ]
}
