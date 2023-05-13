#create the aws vpc
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-vpc"]
  }
}

data "aws_subnet" "subnet_01" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-subnetweb1a"]
  }
}

data "aws_subnet" "subnet_02" {
  filter {
    name   = "tag:Name"
    values = ["2560-dev-alpha-subnetweb1b"]
  }
}