output "alb_dns_name" {
  value       = aws_alb.example.dns_name
  description = "The domain name of the LB"
}

output "asg_name" {
  value       = aws_autoscaling_group.example.name
  description = "The name of the ASG"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the SG attached to the ALB"
}
