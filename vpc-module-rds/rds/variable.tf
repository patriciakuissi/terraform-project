variable "identifier" {
  type    = string
  default = "fruits-db"
}

variable "aws_region" {
    type = string
    default = "us-east-1"
  
}
variable "vers" {
  type    = string
  default = "13.4"
}

variable "instance_class" {
  type    = string
  default = "db.t3.small"
}

variable "allocated_storage" {
  type    = string
  default = "20"
}


variable "max_allocated_storage" {
  type    = string
  default = "100"
}

variable "name" {
  type    = string
  default = "artifactory"
}

variable "username" {
  type    = string
  default = "exampleuser"
}

variable "password" {
  type    = string
  default = "examplepassword"
}

variable "common_tags" {
  type = map(any)
  default = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "Teams"         = "DEL"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }

}
variable "name_parameter" {
  type    = string
  default = "default-postgres12"
}

variable "family" {
  type    = string
  default = "postgres13"
}

variable "multi_az" {
  type    = string
  default = false
}

variable "retention_period" {
  type    = string
  default = "7"
}

variable "deletion_protection" {
  type    = string
  default = false
}

variable "engine" {
  type    = string
  default = "postgres"
}

