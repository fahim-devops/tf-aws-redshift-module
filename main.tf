## Terraform AWS Redshift Module

## data to fetch the current AWS account ID and IAM session context
data "aws_caller_identity" "current" {}
data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

## Fetch Subnet IDs using data
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Tier"
    values = [var.subnet_filter["Tier"]]
  }
}

## Optional Parameter Group for Redshift Cluster
resource "aws_redshift_cluster_parameter_group" "this" {
  count       = var.create_parameter_group ? 1 : 0
  name        = var.parameter_group_name
  family      = var.parameter_group_family
  description = var.parameter_group_description

  parameter {
    for_each = var.parameter_group_parameters
    name     = each.key
    value    = each.value
  }
}

## Security Group for Redshift Cluster
resource "aws_security_group" "redshift_sg" {
name        = "redshift-sg"
  description = "Allow Redshift access"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Redshift access"
    from_port        = 5439
    to_port          = 5439
    protocol         = "tcp"
    cidr_blocks      = var.allowed_cidrs
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = var.tags
}

## Subnet Group for Redshift Cluster
resource "aws_redshift_subnet_group" "this" {
  name       = var.subnet_group_name
  description = var.subnet_group_description
  subnet_ids = data.aws_subnets.selected.ids
  tags       = var.tags
}

## Redshift Cluster Resource
resource "aws_redshift_cluster" "this" {
  cluster_identifier           = var.cluster_identifier
  node_type                    = var.node_type
  master_username              = var.master_username
  master_password              = var.master_password
  database_name                = var.db_name
  cluster_type                 = var.cluster_type
  number_of_nodes              = var.cluster_type == "multi-node" ? var.number_of_nodes : null
  port                         = 5439

  ## Optional parameters
  iam_roles                    = var.iam_roles
  vpc_security_group_ids       = [aws_security_group.redshift_sg.id]
  cluster_subnet_group_name    = aws_redshift_subnet_group.this.name
  publicly_accessible          = var.publicly_accessible
  encrypted                    = var.encrypted
  kms_key_id                   = var.kms_key_id
  availability_zone            = var.availability_zone
  allow_version_upgrade        = var.allow_version_upgrade
  skip_final_snapshot          = var.skip_final_snapshot
  final_snapshot_identifier    = var.skip_final_snapshot ? null : var.final_snapshot_identifier
  tags                         = var.tags

  prevent_destroy             = var.prevent_destroy

  depends_on = [ aws_redshift_subnet_group.this, aws_security_group.redshift_sg ]
}