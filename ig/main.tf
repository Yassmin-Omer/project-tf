resource "aws_internet_gateway" "gateway-1" {
    vpc_id     = var.vpc_id
    tags = {
    Name = var.ig_name
  }

  
}



resource "aws_route_table" "route-table" {
  vpc_id     = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway-1.id
  }
}







