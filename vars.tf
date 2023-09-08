##################################
#      provider variables        #
##################################
variable "tenancy_ocid" {
  default = ""
}

variable "user_ocid" {
  type    = string
  default = ""
}


variable "region" {
  type    = string
  default = ""
}


variable "fingerprint" {
  type    = string
  default = ""
}


variable "private_key_path" {
  type    = string
  default = ""
}

##################################
#      Network variables         #
##################################
variable "vcn_cidr_blocks" {

}

variable "vcn_display_name" {

}

variable "vcn_dns_label" {

}

variable "internet_gateway_display_name" {

}

variable "subnet_public_cidr_block" {

}

variable "subnet_public_display_name" {

}


variable "subnet_public_dns_label" {

}

variable "subnet_private_display_name" {

}

variable "subnet_private_cidr_block" {

}

variable "subnet_private_dns_label" {

}

variable "subnet_private_prohibit_public_ip_on_vnic" {

}

variable "security_list_egress_security_rules_destination" {

}

variable "security_list_egress_security_rules_protocol" {

}

variable "security_list_ingress_security_rules_protocol" {

}

variable "security_list_ingress_security_rules_source" {

}

variable "security_list_egress_security_rules_stateless" {

}

variable "security_list_ingress_security_rules_tcp_options_destination_port_range_max" {

}

variable "security_list_ingress_security_rules_tcp_options_destination_port_range_min" {

}

##################################
#      compute variables         #
##################################

variable "instance_image_ocid" {
  type = map
}