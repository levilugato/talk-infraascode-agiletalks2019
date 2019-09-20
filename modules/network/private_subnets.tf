resource "aws_subnet" "project_agiletalks2019-private-1" {
  vpc_id                  = "${aws_vpc.project_agiletalks2019.id}"
  cidr_block              = "172.31.48.0/20"
  map_public_ip_on_launch = "false"
  availability_zone       = "${element(var.avail_zones[var.aws_region], 0)}"

}

resource "aws_subnet" "project_agiletalks2019-private-2" {
  vpc_id                  = "${aws_vpc.project_agiletalks2019.id}"
  cidr_block              = "172.31.64.0/20"
  map_public_ip_on_launch = "false"
  availability_zone       = "${element(var.avail_zones[var.aws_region], 1)}"

}

resource "aws_subnet" "project_agiletalks2019-private-3" {
  vpc_id                  = "${aws_vpc.project_agiletalks2019.id}"
  cidr_block              = "172.31.80.0/20"
  map_public_ip_on_launch = "false"
  availability_zone       = "${element(var.avail_zones[var.aws_region], 2)}"

}

output "private_subnet_1" {
  value = "${aws_subnet.project_agiletalks2019-private-1.id}"
}

output "private_subnet_2" {
  value = "${aws_subnet.project_agiletalks2019-private-2.id}"
}

output "private_subnet_3" {
  value = "${aws_subnet.project_agiletalks2019-private-3.id}"
}
