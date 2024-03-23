output "alb_dns_name" {
  description = "Domain of ALB"
  value       = aws_alb.example.dns_name
}

output "alb_http_listener_arn" {
  description = "ARN of the HTTP listener"
  value       = aws_alb_listener.http.arn
}

output "alb_security_group_id" {
  description = "ALB SG ID"
  value       = aws_security_group.alb.id
}
