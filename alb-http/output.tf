output "elb-dns-name" {
  value =  aws_lb.httpd_lb.dns_name 
}