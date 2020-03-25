module "redis" {
  source                     = "git::https://github.com/cloudposse/terraform-aws-elasticache-redis.git?ref=tags/0.16.0"
  availability_zones         = var.availability_zones
  namespace                  = var.namespace
  stage                      = var.stage
  name                       = var.name
  zone_id                    = var.zone_id
  vpc_id                     = module.networking.vpc_id
  allowed_security_groups    = [module.networking.vpc_default_security_group_id]
  subnets                    = module.networking.private_subnet_ids
  cluster_size               = var.cluster_size
  instance_type              = var.instance_type_redis
  apply_immediately          = true
  automatic_failover_enabled = false
  engine_version             = var.engine_version_redis
  family                     = var.family
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled

  parameter = [
    {
      name  = "notify-keyspace-events"
      value = "lK"
    }
  ]
}