output "asg_name" {
  description = "name of th ASG"
  value       = aws_autoscaling_group.example.name
}

output "instance_security_group_id" {
  description = "ID of EC2 instance SG"
  value       = aws_security_group.instance.id
}
