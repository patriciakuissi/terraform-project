# 1- create vpc
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
}
# 2- create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "prod"
  }
}
# 3- create custum Route Table

resource "aws_route_table" "dev-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
     gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "dev"
  }
}
# 4- Create a subnet 

resource "aws_subnet" "dev-subnet" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.0.0/16"
  availability_zone = "us-east-1a"

  tags = {
    Name = "dev-subnet"
  }
}
# 5- associate Subnet with Route Table 

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.dev-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}
# 6- create Security group to allow port 22, 80, 443

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffi"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.dev-vpc.id

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }

ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
} 
   ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

# 7- Create a network interface with an ip in the subnet that was create in step 4

resource "aws_network_interface" "web-interface" {
  subnet_id       = aws_subnet.dev-subnet.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.allow_web.id]
}
# 8- Assign an elastic Ip to the network interface create in step 7

resource "aws_eip" "elasticip-dev" {
  vpc                       = true
  network_interface         = aws_network_interface.web-interface.id
  associate_with_private_ip = "10.0.0.50"
  depends_on                = [aws_internet_gateway.gw]
}

# 9- create Ubuntu server and install/enable apache2

resource "aws_instance" "dev-ec2" {
  ami                    = "ami-007855ac798b5175e"
  instance_type         = "t2.micro"
  key_name         =    "patricia-keypair"
  availability_zone = "us-east-1a"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web-interface.id
  }
  
    tags = {
        Name = "ec2-prod"
    }           
}