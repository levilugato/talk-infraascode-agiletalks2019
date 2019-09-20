resource "aws_subnet" "project_agiletalks2019-public-1" {
  vpc_id                  = "${aws_vpc.project_agiletalks2019.id}"
  cidr_block              = "172.31.0.0/20"
  map_public_ip_on_launch = "true"
  availability_zone       = "${element(var.avail_zones[var.aws_region], 0)}"
}

resource "aws_subnet" "project_agiletalks2019-public-2" {
  vpc_id                  = "${aws_vpc.project_agiletalks2019.id}"
  cidr_block              = "172.31.16.0/20"
  map_public_ip_on_launch = "true"
  availability_zone       = "${element(var.avail_zones[var.aws_region], 1)}"

}

resource "aws_subnet" "project_agiletalks2019-public-3" {
  vpc_id                  = "${aws_vpc.project_agiletalks2019.id}"
  cidr_block              = "172.31.32.0/20"
  map_public_ip_on_launch = "true"
  availability_zone       = "${element(var.avail_zones[var.aws_region], 2)}"

}

output "public_subnet_1" {
  value = "${aws_subnet.project_agiletalks2019-public-1.id}"
}

output "public_subnet_2" {
  value = "${aws_subnet.project_agiletalks2019-public-2.id}"
}

output "public_subnet_3" {
  value = "${aws_subnet.project_agiletalks2019-public-3.id}"
}
