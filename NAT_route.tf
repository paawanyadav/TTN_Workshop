# route table with target as NAT gateway
#resource "aws_route_table" "NAT_route_table" {
#  vpc_id = aws_vpc.vpc.id
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_nat_gateway.nat_gateway.id
#  }
#  tags = {
#    Name = "NAT-route-table"
#  }
#}

# associate route table to private subnet
#resource "aws_route_table_association" "associate_routetable_to_private_subnet" {
#  subnet_id      = aws_subnet.private_subnet.id
#  route_table_id = aws_route_table.NAT_route_table.id
#}
