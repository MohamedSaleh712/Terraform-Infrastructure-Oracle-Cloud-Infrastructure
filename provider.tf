terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "5.12.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  region           = var.region
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

