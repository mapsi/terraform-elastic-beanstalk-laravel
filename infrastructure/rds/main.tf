module "rds_instance" {
  source              = "git::https://github.com/cloudposse/terraform-aws-rds.git?ref=tags/0.18.0"
  namespace           = var.namespace
  stage               = var.stage
  name                = var.name
  database_name       = var.database_name
  database_user       = var.database_user
  database_password   = var.database_password
  database_port       = var.database_port
  multi_az            = var.multi_az
  storage_type        = var.storage_type
  allocated_storage   = var.allocated_storage
  storage_encrypted   = var.storage_encrypted
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  db_parameter_group  = var.db_parameter_group
  publicly_accessible = var.publicly_accessible
  vpc_id              = module.networking.vpc_id
  subnet_ids          = module.networking.private_subnet_ids
  security_group_ids  = [module.networking.vpc_default_security_group_id]
  apply_immediately   = var.apply_immediately

  db_parameter = [
    {
      name         = "myisam_sort_buffer_size"
      value        = "1048576"
      apply_method = "immediate"
    },
    {
      name         = "sort_buffer_size"
      value        = "2097152"
      apply_method = "immediate"
    }
  ]
}
