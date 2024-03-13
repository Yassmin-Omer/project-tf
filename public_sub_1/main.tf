resource "aws_subnet" "public-subnet-1" {
    vpc_id     = var.vpc_id
 cidr_block = var.cidr_public_subnet_1
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = var.sub_name_1
  }
}



 


 # Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" { 
  
}

# Create a NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id
}

# Create a route table for the private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.route_table_name
  }
}

# Associate the private route table with the private subnet
resource "aws_route_table_association" "private_route_association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create a default route to the NAT Gateway for 0.0.0.0/0 in the private route table
resource "aws_route" "private_default_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}


