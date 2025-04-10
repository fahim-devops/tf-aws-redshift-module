variable "region" {
  description = "a variable of type string"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID where the Redshift cluster will be created"
  type        = string
  default     = null
}

variable "allowed_cidrs" {
  description = "values for the cidr blocks"
  type        = list(string)
  default     = null
}

variable "cluster_name" {
  description = "Name of the Redshift cluster"
  type        = string
  default     = "prod-eks-tenforty"
}

## Basic Cluster Configuration

variable "cluster_identifier" {
  description = "Unique identifier for the Redshift cluster"
  type        = string
}

variable "node_type" {
  description = "The node type to be provisioned for the cluster"
  type        = string
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "master_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the first database to be created when the cluster is created"
  type        = string
  default     = "dev"
}

## Cluster Sizing and Networking
variable "cluster_type" {
  description = "Type of the cluster. Valid values: single-node, multi-node"
  type        = string
  default     = "single-node"
}

variable "number_of_nodes" {
  description = "The number of compute nodes. Required when cluster_type is multi-node"
  type        = number
  default     = 2
}

variable "port" {
  description = "The port number on which the cluster accepts connections"
  type        = number
  default     = 5439
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to be associated with the cluster"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "List of subnet IDs for the subnet group"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "Name of the Redshift subnet group"
  type        = string
}

variable "subnet_group_description" {
  description = "Description for the subnet group"
  type        = string
  default     = "Redshift subnet group"
}

## IAM & Accessibility

variable "publicly_accessible" {
  description = "Whether the cluster is publicly accessible"
  type        = bool
  default     = false
}

variable "iam_roles" {
  description = "List of IAM role ARNs to associate with the cluster"
  type        = list(string)
  default     = []
}

## Encryption & Availability

variable "kms_key_id" {
  description = "KMS key ID for encryption"
  type        = string
  default     = null
}

variable "encrypted" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "availability_zone" {
  description = "The availability zone for the cluster"
  type        = string
  default     = null
}

## Maintenance & Final Snapshot

variable "allow_version_upgrade" {
  description = "If true, major version upgrades can be applied during maintenance windows"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot is created before the cluster is deleted"
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "The identifier of the final snapshot that is to be created immediately before deleting the cluster"
  type        = string
  default     = null
}

## Optional Parameter Group

variable "create_parameter_group" {
  description = "Whether to create a parameter group"
  type        = bool
  default     = false
}

variable "parameter_group_name" {
  description = "Name of the parameter group"
  type        = string
  default     = null
}

variable "parameter_group_description" {
  description = "Description for the parameter group"
  type        = string
  default     = "Redshift parameter group"
}

variable "parameter_group_family" {
  description = "The family of the Redshift parameter group (e.g. redshift-1.0)"
  type        = string
  default     = "redshift-1.0"
}

variable "parameter_group_parameters" {
  description = "Map of Redshift parameters to set"
  type        = map(string)
  default     = {}
}

## Tagging

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}