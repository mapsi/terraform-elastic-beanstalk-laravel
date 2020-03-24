provider "aws" {
  region = var.region
}

module "networking" {
  source = "./infrastructure/networking"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  tags       = var.tags
  delimiter  = var.delimiter

  availability_zones = var.availability_zones
}

module "elastic_beanstalk_application" {
  source      = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application.git?ref=tags/0.4.0"
  namespace   = var.namespace
  stage       = var.stage
  name        = var.name
  attributes  = var.attributes
  tags        = var.tags
  delimiter   = var.delimiter
  description = "Test elastic_beanstalk_application"
}

module "elastic_beanstalk_environment" {
  source                     = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment.git?ref=tags/0.18.0"
  namespace                  = var.namespace
  stage                      = var.stage
  name                       = var.name
  attributes                 = var.attributes
  tags                       = var.tags
  delimiter                  = var.delimiter
  description                = var.description
  region                     = var.region
  availability_zone_selector = var.availability_zone_selector
  dns_zone_id                = var.dns_zone_id

  wait_for_ready_timeout             = var.wait_for_ready_timeout
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  environment_type                   = var.environment_type
  loadbalancer_type                  = var.loadbalancer_type
  elb_scheme                         = var.elb_scheme
  tier                               = var.tier
  version_label                      = var.version_label
  force_destroy                      = var.force_destroy

  instance_type    = var.instance_type_ec2
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type

  managed_actions_enabled  = var.managed_actions_enabled
  preferred_start_time     = var.preferred_start_time
  update_level             = var.update_level
  instance_refresh_enabled = var.instance_refresh_enabled

  autoscale_min             = var.autoscale_min
  autoscale_max             = var.autoscale_max
  autoscale_measure_name    = var.autoscale_measure_name
  autoscale_statistic       = var.autoscale_statistic
  autoscale_unit            = var.autoscale_unit
  autoscale_lower_bound     = var.autoscale_lower_bound
  autoscale_lower_increment = var.autoscale_lower_increment
  autoscale_upper_bound     = var.autoscale_upper_bound
  autoscale_upper_increment = var.autoscale_upper_increment

  vpc_id                  = module.networking.vpc_id
  loadbalancer_subnets    = module.networking.public_subnet_ids
  application_subnets     = module.networking.private_subnet_ids
  allowed_security_groups = [module.networking.vpc_default_security_group_id]

  rolling_update_enabled  = var.rolling_update_enabled
  rolling_update_type     = var.rolling_update_type
  updating_min_in_service = var.updating_min_in_service
  updating_max_batch      = var.updating_max_batch

  healthcheck_url  = var.healthcheck_url
  application_port = var.application_port

  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html
  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = var.solution_stack_name

  additional_settings = var.additional_settings
  env_vars = {
    "DB_HOST"     = module.rds_instance.instance_endpoint
    "DB_SCHEMA"   = var.database_name
    "DB_USERNAME" = var.database_user
    "DB_PASSWORD" = var.database_password
  }
}

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