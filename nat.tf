# elastic ip
#resource "aws_eip" "elastic_ip" {
#  vpc = true
#}

# NAT gateway
#resource "aws_nat_gateway" "nat_gateway" {
#  allocation_id = aws_eip.elastic_ip.id
#  subnet_id     = aws_subnet.public_subnet.id

#  tags = {
#    Name = "nat-gateway"
#  }
#}
