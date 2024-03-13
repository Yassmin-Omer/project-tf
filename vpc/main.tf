resource "aws_vpc" "vpc" {
    cidr_block  = var.cidr_vpc
    tags = {
    Name = var.vpc_name
  }
  
}

output "vpc_id" {
    value = aws_vpc.vpc.id 
  
}