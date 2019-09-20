module "network" {
  source      = "./modules/network"
  avail_zones = "${var.avail_zones}"
  aws_region  = "${var.aws_region}"
}

module "manager" {
  source = "./modules/manager"

  aws_region    = "${var.aws_region}"
  instance_type = "${var.instance_type}"
  ami           = "${var.ami}"
}

output "public_ips" {
  value = "${module.manager.master_ip}"
}

output "private_key" {
  value = "${module.manager.tls_public_key}"
}

output "elb_dns" {
  value = "${module.manager.elb_external}"
}
