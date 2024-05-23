terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  # osaka region
  region = "ap-northeast-3"
}

resource "aws_key_pair" "dev_server_key" {
  key_name   = "dev-server-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "dev_server" {
  # Amazon Linux 2 AMI (HVM), SSD Volume Type
  ami           = "ami-0f33119c704c2aa59"
  instance_type = "t2.micro"

  key_name = aws_key_pair.dev_server_key.key_name

  subnet_id = "subnet-0caa2c25e65a6ef27"

  vpc_security_group_ids = ["sg-0f7ee2d3ad56da316"]

  tags = {
    Name = "MyDevServerInstance"
  }
}
