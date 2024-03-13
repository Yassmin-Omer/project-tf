

resource "aws_instance" "nginx_instance" {
  ami           = var.ami
  instance_type = "t2.micro"                     
  associate_public_ip_address = true
  #key_name = "yassmin"
  subnet_id = var.subnet_id
  tags = {
    Name = "nginx-instance"
  }






/*   provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      # Configure NGINX to forward traffic to the ELB
      "sudo bash -c 'cat <<EOF > /etc/nginx/conf.d/default.conf",
      "server {",
      "  listen 80;",
      "  server_name your_domain_name_or_ip;",
      "  location / {",
      "    proxy_pass http://${var.dns_name};",
      "  }",
      "}'",
      "sudo service nginx restart",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/yassmin/project-tf/key.pem")  
      host        = self.public_ip
    }
  } */

    user_data = <<-EOF
              #!/bin/bash
              sudo amazon-linux-extras install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx

              # Configure NGINX to forward traffic to the ELB
              sudo bash -c 'cat <<EOL > /etc/nginx/conf.d/default.conf
              server {
                listen 80;
                server_name your_domain_name_or_ip;
                location / {
                  proxy_pass http://${var.dns_name};
                }
              }
              EOL'

              sudo service nginx restart
              EOF
  vpc_security_group_ids = var.vpc_security_group_ids
}







