variable "cluster_size" {
  type        = number
  description = "Number of nodes in cluster"
}

variable "instance_type_redis" {
  type        = string
  description = "Elastic cache instance type"
}

variable "family" {
  type        = string
  description = "Redis family"
}

variable "engine_version_redis" {
  type        = string
  description = "Redis engine version"
}

variable "at_rest_encryption_enabled" {
  type        = bool
  description = "Enable encryption at rest"
}

variable "transit_encryption_enabled" {
  type        = bool
  description = "Enable TLS"
}

variable "zone_id" {
  type        = string
  description = "Route53 DNS Zone ID"
}