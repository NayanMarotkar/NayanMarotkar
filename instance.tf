terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_security_group" "my-sg" {
    name = "my-sg"
    description = "allow all traffic outbound rule allow ssh and http"
    vpc_id = aws_vpc.my-vpc.id

    tags = {
      Name = "$(var.aws_tags)-my-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
    security_group_id = aws_security_group.my-sg.id
    from_port = 22
    to_port = 22
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
    security_group_id = aws_security_group.my-sg.id
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "all-tcp" {
    security_group_id = aws_security_group.my-sg.id
    ip_protocol = -1
    cidr_ipv4 = "0.0.0.0/0"
}
resource "aws_instance" "my-instance" {
    ami = var.aws_ami_value
    instance_type = var.aws_instance_type_value
    key_name = "k8s"
    security_groups = [aws_security_group.my-sg.id]
    subnet_id = aws_subnet.public-subnet-1.id
    associate_public_ip_address = true

    tags = {
      Name = "$(var.aws_tags)-my-instance"
    }
  
}
