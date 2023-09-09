data "oci_identity_availability_domain" "domain_1" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

resource "oci_core_vcn" "wind-is_vcn" {
  compartment_id = var.tenancy_ocid

  #Optional
  cidr_blocks  = var.vcn_cidr_blocks
  display_name = var.vcn_display_name
  dns_label    = var.vcn_dns_label
}


resource "oci_core_subnet" "subnet_public" {
  cidr_block     = var.subnet_public_cidr_block
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.wind-is_vcn.id

  availability_domain = data.oci_identity_availability_domain.domain_1.name
  display_name        = var.subnet_public_display_name
  dns_label           = var.subnet_public_dns_label
  route_table_id      = oci_core_route_table.route_table_public.id

  security_list_ids = [oci_core_security_list.security_list.id]
  dhcp_options_id   = oci_core_vcn.wind-is_vcn.default_dhcp_options_id
}


resource "oci_core_subnet" "subnet_private" {
  #Required
  cidr_block     = var.subnet_private_cidr_block
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.wind-is_vcn.id

  #Optional
  availability_domain = data.oci_identity_availability_domain.domain_1.name
  display_name        = var.subnet_private_display_name
  dns_label           = var.subnet_private_dns_label

  prohibit_public_ip_on_vnic = var.subnet_private_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.route_table_private.id
  security_list_ids          = [oci_core_security_list.security_list.id]
  dhcp_options_id            = oci_core_vcn.wind-is_vcn.default_dhcp_options_id
}

resource "oci_core_route_table" "route_table_public" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.wind-is_vcn.id
  display_name   = var.route_table_public_display_name
  route_rules {
    #Required
    network_entity_id = oci_core_internet_gateway.wind-is_internet_gateway.id

    #Optional
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

resource "oci_core_route_table" "route_table_private" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.wind-is_vcn.id
  display_name   = var.route_table_private_display_name
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}

# resource "oci_core_route_table_attachment" "route_table_public_attach" {
#   subnet_id      = oci_core_subnet.subnet_public.id
#   route_table_id = oci_core_route_table.route_table_public.id
# }

# resource "oci_core_route_table_attachment" "route_table_private_attach" {
#   subnet_id      = oci_core_subnet.subnet_private.id
#   route_table_id = oci_core_route_table.route_table_private.id
# }

resource "oci_core_internet_gateway" "wind-is_internet_gateway" {
  #Required
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.wind-is_vcn.id

  #Optional
  # enabled = var.internet_gateway_enabled
  display_name = var.internet_gateway_display_name
  # route_table_id = oci_core_route_table.test_route_table.id
}

resource "oci_core_nat_gateway" "nat_gateway" {

  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.wind-is_vcn.id

  display_name = "nat_gateway"
  # route_table_id = oci_core_route_table.route_table_private.id
}

resource "oci_core_security_list" "security_list" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.wind-is_vcn.id
  egress_security_rules {
    stateless   = false
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
  ingress_security_rules {
    protocol = var.security_list_ingress_security_rules_protocol
    source   = var.security_list_ingress_security_rules_source
    tcp_options {
      max = var.security_list_ingress_security_rules_tcp_options_destination_port_range_max
      min = var.security_list_ingress_security_rules_tcp_options_destination_port_range_min
    }
  }
}