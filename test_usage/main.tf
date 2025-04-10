module "redshift" {
  source                   = "../"

  ## Required variables
  region                   = "us-east-1"
  vpc_id                   = "vpc-60fc981d"
  allowed_cidrs            = ["172.31.0.0/16"]
  cluster_identifier       = "my-redshift-cluster"
  node_type                = "dc2.large"
  master_username          = "admin"
  master_password          = "YourStrongPassword1!"
  db_name                  = "dev"
  port                     = 5439
  iam_roles                = ["arn:aws:iam::123456789012:role/MyRedshiftRole"]
  encrypted                = true
  subnet_filter = {
  Tier = "private"
}
  # kms_key_id               = "arn:aws:kms:us-east-1:123456789012:key/abcd1234-abcd-1234-abcd-1234567890ab"

  ## Networking (must exist already)
  subnet_group_name        = "redshift-subnet-group"
  #vpc_security_group_ids   = ["sg-12345678"]

  ## Optional variables
  publicly_accessible      = false
  cluster_type             = "single-node"
  number_of_nodes          = null
  tags = {
    Environment = "dev"
    Team        = "data-engineering"
  }
}