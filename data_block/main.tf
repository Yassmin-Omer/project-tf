data "aws_ami" "linux-ami" {
    most_recent = true
    filter {
      name = "name"
      values = ["al2023-ami-2023.*-x86_64"]
    }
}




#create security group 
resource "aws_security_group" "sg_1" {
  name        = "sg_cu"
  description = "Allow inbound traffic on port 80 and 22"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id =   var.vpc_id
  
}


