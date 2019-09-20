resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.project_agiletalks2019-public-1.id}"
  depends_on    = ["aws_internet_gateway.project_agiletalks2019-gw"]
}

# VPC setup for NAT
resource "aws_route_table" "project_agiletalks2019-private" {
  vpc_id = "${aws_vpc.project_agiletalks2019.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }

  lifecycle {
    ignore_changes = [
      "route",
    ]
  }


}

# route associations private
resource "aws_route_table_association" "project_agiletalks2019-private-1-a" {
  subnet_id      = "${aws_subnet.project_agiletalks2019-private-1.id}"
  route_table_id = "${aws_route_table.project_agiletalks2019-private.id}"
}

resource "aws_route_table_association" "project_agiletalks2019-private-2-a" {
  subnet_id      = "${aws_subnet.project_agiletalks2019-private-2.id}"
  route_table_id = "${aws_route_table.project_agiletalks2019-private.id}"
}

resource "aws_route_table_association" "project_agiletalks2019-private-3-a" {
  subnet_id      = "${aws_subnet.project_agiletalks2019-private-3.id}"
  route_table_id = "${aws_route_table.project_agiletalks2019-private.id}"
}

# output
output "nat_gw_ip" {
  value = "${aws_eip.nat.public_ip}"
}

output "nat_gw_dummy_dependency" {
  value = "${aws_nat_gateway.nat-gw.id}"
}

output "priv_route_table_assoc_dependency" {
  value = "${join("-", list(
    aws_route_table_association.project_agiletalks2019-private-1-a.id,
    aws_route_table_association.project_agiletalks2019-private-2-a.id,
    aws_route_table_association.project_agiletalks2019-private-3-a.id
  ))}"
}
