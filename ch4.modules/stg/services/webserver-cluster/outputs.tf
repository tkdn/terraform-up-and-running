output "alb_dns_name" {
  value       = aws_alb.example.dns_name
  description = "The domain name of the LB"
}
