resource "tls_private_key" "project_agtlk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "project_agtlk" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.project_agtlk.public_key_openssh}"
}

resource "aws_instance" "agiletalks2019EC2" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.project_agtlk.id}"
  count                       = "2"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = ["${aws_security_group.project_agiletalks2019.id}"]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = false
  }

  lifecycle {
    create_before_destroy = true
  }

  provisioner "file" {
    source      = "${path.module}/install-docker.sh"
    destination = "/tmp/install-docker.sh"
  }

  connection {
    user    = "ec2-user"
    private_key = "${tls_private_key.project_agtlk.private_key_pem}"
    host =  "${self.public_ip}"
    timeout = "1m"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-docker.sh",
      "/tmp/install-docker.sh"
    ]
  }
}

output "master_ip" {
  value = "${aws_instance.agiletalks2019EC2.*.public_ip}"
  }

output "instance_ids" {
  value = ["${aws_instance.agiletalks2019EC2.*.id}"]
  }

output "tls_public_key" {
  value = "${tls_private_key.project_agtlk.private_key_pem}"
}