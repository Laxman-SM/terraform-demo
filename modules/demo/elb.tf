resource "aws_elb" "web" {
  name = "${var.infra_name}-web"
  subnets = ["${aws_subnet.public_subnet.id}"]
  security_groups = ["${aws_security_group.web_security_group.id}","${aws_vpc.vpc.default_security_group_id}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:80"
    interval = 10
  }

  instances = ["${aws_instance.server.*.id}"]
  cross_zone_load_balancing = false
  idle_timeout = 60
  connection_draining = true
  connection_draining_timeout = 120

  tags {
    Name = "${var.infra_name}-web"
  }
}
