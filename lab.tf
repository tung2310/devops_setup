terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "ap-southeast-1"
}

locals {
  ami           = "ami-06c4be2792f419b7b"
  instance_type = "t2.micro"
  name          = "lab"
  key_pair      = "tung2802"
}

data "aws_vpc" "main_vpc" {
  default = true
}

data "aws_security_group" "sg01" {
  id = "sg-0acf3cb034992b865"
}

data "aws_subnet" "my_subnet1" {
  id = "subnet-02cd9ff4659f8ecb8"
}

resource "aws_instance" "master" {
  ami           = local.ami
  instance_type = local.instance_type
  key_name      = local.key_pair
  vpc_security_group_ids = [ data.aws_security_group.sg01.id ]
  subnet_id = data.aws_subnet.my_subnet1.id
  associate_public_ip_address = "true"

  tags = {
    Name = "master"
  }
}

# resource "aws_instance" "web1" {
#   ami           = local.ami
#   instance_type = local.instance_type
#   key_name      = local.key_pair
#   vpc_security_group_ids = [ data.aws_security_group.sg01.id ]
#   subnet_id = data.aws_subnet.my_subnet1.id
#   associate_public_ip_address = "true"

#   tags = {
#     Name = "web1"
#   }
# }

# resource "aws_instance" "web2" {
#   ami           = local.ami
#   instance_type = local.instance_type
#   key_name      = local.key_pair
#   vpc_security_group_ids = [ data.aws_security_group.sg01.id ]
#   subnet_id = data.aws_subnet.my_subnet1.id
#   associate_public_ip_address = "true"

#   tags = {
#     Name = "web2"
#   }
# }