##################################
#      provider variables        #
##################################
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "region" {}
variable "fingerprint" {}
variable "private_key_path" {}

##################################
#      Network variables         #
##################################
variable "vcn_cidr_blocks" {}
variable "vcn_display_name" {}
variable "vcn_dns_label" {}
variable "internet_gateway_display_name" {}
variable "subnet_public_cidr_block" {}
variable "subnet_public_display_name" {}
variable "subnet_public_dns_label" {}
variable "subnet_private_display_name" {}
variable "subnet_private_cidr_block" {}
variable "subnet_private_dns_label" {}
variable "subnet_private_prohibit_public_ip_on_vnic" {}
variable "route_table_public_display_name" {}
variable "route_table_private_display_name" {}
variable "security_list_egress_security_rules_destination" {}
variable "security_list_egress_security_rules_protocol" {}
variable "security_list_ingress_security_rules_protocol" {}
variable "security_list_ingress_security_rules_source" {}
variable "security_list_egress_security_rules_stateless" {}
variable "security_list_ingress_security_rules_tcp_options_destination_port_range_max" {}
variable "security_list_ingress_security_rules_tcp_options_destination_port_range_min" {}
variable "cidr_ingress" {}

##################################
#      compute variables         #
##################################

variable "instance_image_ocid" {}
variable "instance_shape" {}
variable "instance_display_name" {}
variable "hostname_label" {}
variable "http_sg_name" {}
variable "ssh_public_key" {}
variable "portz" { type = list(any) }
variable "user_data" {
  default = <<EOF
#!/bin/bash

yum update -y
yum install httpd -y
systemctl enable httpd
EOF  
}