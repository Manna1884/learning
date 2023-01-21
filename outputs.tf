output "lb_dns_url" {
 description = "dns of webserver load balancer"
  value = aws_lb.alb.dns_name
}