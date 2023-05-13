
identifier = "example"
version = "13.4"
instance_class = "db.t3.small"
vpc_id = "vpc-0a94db89344c16694"
name_parameter = "default-postgres12"
family = "postgres13"
multi_az = false
retention_period = 7
deletion_protection = false
engine = "postgre"
allocated_storage = 20
max_allocated_storage = 100
name = "artifactory"
username = "exampleuser"
password = "examplepassword"


common_tags = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "Teams"         = "DEL"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
}
