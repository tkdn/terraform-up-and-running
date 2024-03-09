output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "The domain name of the LB"
}

output "asg_name" {
  value       = module.asg.asg_name
  description = "The name of the ASG"
}

output "alb_security_group_id" {
  value       = module.asg.instance_security_group_id
  description = "The ID of the SG attached to the ALB"
}
