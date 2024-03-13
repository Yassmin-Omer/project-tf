

# Define Application Load Balancer (ALB)
resource "aws_lb" "nginx_lb" {
  name               = "nginx-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.vpc_security_group_ids
  enable_deletion_protection = false
  enable_http2                = true
  subnets = [  var.subnet_id ,var.subnet_id_2]
  
}

# Define ALB target group
resource "aws_lb_target_group" "nginx_target_group" {
  name     = "nginx-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Attach instances to the target group
resource "aws_lb_target_group_attachment" "instance1" {
  target_group_arn = aws_lb_target_group.nginx_target_group.arn
  target_id        = var.instance-id-1
}

resource "aws_lb_target_group_attachment" "instance2" {
  target_group_arn = aws_lb_target_group.nginx_target_group.arn
  target_id        = var.instance-id-2
}

# Define ALB listener
resource "aws_lb_listener" "nginx_listener" {
  load_balancer_arn = aws_lb.nginx_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}
