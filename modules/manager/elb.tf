## Security Group for ELB
resource "aws_security_group" "elb" {
  name = "terraform-example-elb"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "project-agtlks" {
  name = "project-agtlks-elb"
  security_groups = ["${aws_security_group.elb.id}"]
  availability_zones = ["us-east-1a"]
  instances = "${aws_instance.agiletalks2019EC2.*.id}"
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}

output "elb_external" {
  value = "${aws_elb.project-agtlks.dns_name}"
}