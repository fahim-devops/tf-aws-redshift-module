output "redshift_cluster_endpoint" {
  description = "Endpoint of the Redshift cluster"
  value       = aws_redshift_cluster.this.endpoint
}

output "redshift_cluster_id" {
  description = "ID of the Redshift cluster"
  value       = aws_redshift_cluster.this.id
}

output "redshift_cluster_arn" {
  description = "ARN of the Redshift cluster"
  value       = aws_redshift_cluster.this.arn
}

output "redshift_security_group_id" {
  description = "ID of the security group associated with the Redshift cluster"
  value = aws_security_group.redshift_sg.id
}