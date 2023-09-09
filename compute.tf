resource "oci_core_instance" "webserver" {
  availability_domain = data.oci_identity_availability_domain.domain_1.name
  compartment_id      = var.tenancy_ocid
  shape               = var.instance_shape
  display_name        = var.instance_display_name

  metadata = {
    #   ssh_authorized_keys = file("~/.ssh/id_rsa.pub")
    user_data = "${base64encode(var.user_data)}"
  }

  create_vnic_details {
    subnet_id      = oci_core_subnet.subnet_private.id
    hostname_label = var.hostname_label
  }

  source_details {
    #Required
    source_id   = var.instance_image_ocid
    source_type = "image"
  }
}

resource "oci_core_network_security_group" "http_sg" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.wind-is_vcn.id
  display_name   = var.http_sg_name
}
