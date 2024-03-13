resource "aws_instance" "apache_instance_2" {
  ami           = var.ami
  instance_type = "t2.micro"                     
  associate_public_ip_address = false
  key_name = "vockey"
  subnet_id = var.subnet_id_2
  tags = {
    Name = "apache-instance-2"
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo echo "Hello from httpd_2" | sudo tee /var/www/html/index.html
    sudo systemctl restart httpd
  EOF
  vpc_security_group_ids = var.vpc_security_group_ids
}