resource "aws_vpc" "project_agiletalks2019" {
  cidr_block           = "172.31.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
}

# Internet GW
resource "aws_internet_gateway" "project_agiletalks2019-gw" {
  vpc_id = "${aws_vpc.project_agiletalks2019.id}"

}

# route tables
resource "aws_route_table" "project_agiletalks2019-public" {
  vpc_id = "${aws_vpc.project_agiletalks2019.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.project_agiletalks2019-gw.id}"
  }

  lifecycle {
    ignore_changes = [
      "route",
    ]
  }

}

# route associations public
resource "aws_route_table_association" "project_agiletalks2019-public-1-a" {
  subnet_id      = "${aws_subnet.project_agiletalks2019-public-1.id}"
  route_table_id = "${aws_route_table.project_agiletalks2019-public.id}"
}

resource "aws_route_table_association" "project_agiletalks2019-public-2-a" {
  subnet_id      = "${aws_subnet.project_agiletalks2019-public-2.id}"
  route_table_id = "${aws_route_table.project_agiletalks2019-public.id}"
}

resource "aws_route_table_association" "project_agiletalks2019-public-3-a" {
  subnet_id      = "${aws_subnet.project_agiletalks2019-public-3.id}"
  route_table_id = "${aws_route_table.project_agiletalks2019-public.id}"
}

# Output
output "vpc_id" {
  value = "${aws_vpc.project_agiletalks2019.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.project_agiletalks2019.cidr_block}"
}

output "igw_dependency" {
  value = "${aws_internet_gateway.project_agiletalks2019-gw.id}"
}
