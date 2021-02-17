variable "engine" {}
variable "db_version" {}
variable "size" {}
variable "region" {}
variable "name" {}
variable "vpc_id" {}
#variable "enviroment" {}
variable "tenant" {
  type        = string
  default     = ""
  description = "The tenant tag"
}

variable "environment" {
  type        = string
  default     = ""
  description = "The environment tag"
}
