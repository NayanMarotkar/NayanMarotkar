variable "aws_vpc_value" {
    description = "value for vpc"
    type = string
    default = "10.0.0.0/16"
}

variable "aws_public_subnet_value" {
    type = string
    description = "value for public subnet"
    default = "10.0.1.0/24"
}

variable "aws_private_subnet_value" {
    type = string
    description = "value for private subnet"
    default = "10.0.2.0/24"
}

variable "aws_tags" {
    default = "my-app"
}

variable "aws_ami_value" {
    description = "value for ami"
    default = "ami-03bb6d83c60fc5f7c"
}

variable "aws_instance_type_value" {
    description = "value for instance type"
    default = "t2.micro"
}
