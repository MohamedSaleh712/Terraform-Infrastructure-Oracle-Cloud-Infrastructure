resource "oci_load_balancer" "lb" {
  compartment_id = var.tenancy_ocid
  display_name   = "my-lb"
  shape          = "100Mbps"
  subnet_ids     = [oci_core_subnet.subnet_private.id]
}

resource "oci_load_balancer_backend_set" "lb_backend_set" {
  name             = "lb_backend_set"
  load_balancer_id = oci_load_balancer.lb.id
  policy           = "ROUND_ROBIN"
  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

resource "oci_load_balancer_hostname" "lb_hostname" {
  load_balancer_id = oci_load_balancer.lb.id
  hostname         = "app.example.com"
  name             = "hostname1"
}


resource "oci_load_balancer_listener" "lb_load_listener" {
  load_balancer_id         = oci_load_balancer.lb.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.lb_backend_set.name
  hostname_names           = [oci_load_balancer_hostname.lb_hostname.name]
  port                     = 80
  protocol                 = "HTTP"
  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}

resource "oci_load_balancer_backend" "lb_backend" {
  load_balancer_id = oci_load_balancer.lb.id
  backendset_name  = oci_load_balancer_backend_set.lb_backend_set.name
  ip_address       = oci_core_instance.webserver.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

output "lb_public_ip" {
  value = ["${oci_load_balancer.lb.ip_address_details}"]
}







