#target group
resource "aws_lb_target_group" "httpd_tg" {
 health_check {
  interval = 10
  path =   "/"
  protocol = "HTTP"
  timeout = 5
  healthy_threshold = 5
  unhealthy_threshold = 2
 } 

 name = "whith-tg"
 port = 80
 protocol = "HTTP"
 target_type = "instance"
 vpc_id = var.vpc_id
}

#create alb
resource "aws_lb" "httpd_lb" {
  name               = "httpd-lb"
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = var.vpc_security_group_ids
  subnets            = [var.subnet_id , var.subnet_id_2]  

  enable_deletion_protection = false
  tags = {
    Name= "http-lb"
  }
}



#create listner
resource "aws_lb_listener" "httpd_listener" {
  load_balancer_arn = aws_lb.httpd_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.httpd_tg.arn
    type             = "forward"
  }
}


/* #attachment
resource "aws_lb_target_group_attachment" "ec2_attach" {
    target_group_arn = aws_lb_target_group.httpd_tg.arn
   target_id = [
    var.apache_instance_id,
    var.apache_instance_id_2
  ]
} */




resource "aws_lb_target_group_attachment" "ec2_attach_1" {
  target_group_arn = aws_lb_target_group.httpd_tg.arn
  target_id        = var.apache_instance_id
}

resource "aws_lb_target_group_attachment" "ec2_attach_2" {
  target_group_arn = aws_lb_target_group.httpd_tg.arn
  target_id        = var.apache_instance_id_2
}























