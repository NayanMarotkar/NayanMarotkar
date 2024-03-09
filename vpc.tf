resource "aws_vpc" "my-vpc" {
    cidr_block = var.aws_vpc_value
}

resource "aws_subnet" "public-subnet-1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.aws_public_subnet_value

    tags = {
      Name = "$(var.aws_tags)-public-subnet-1"
    }
}

resource "aws_subnet" "private-subnet-1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block =  var.aws_private_subnet_value

    tags = {
      Name = "$(var.aws_tags)-private-subnet-1"
    }
}

resource "aws_route_table_association" "public-rt-a" {
    subnet_id = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.public-rt.id
  
}

resource "aws_route_table_association" "private-rt-a" {
    subnet_id = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-rt.id
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my-vpc.id

    tags = {
        Name = "$(var.aws_tags)-igw"
    }
}

resource "aws_eip" "eip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.private-subnet-1.id

    tags = {
      Name = "$(var.aws_tags)-nat"
    }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "$(var.aws_tags)-public-rt"
  }
}

resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.my-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
      Name = "$(var.aws_tags)-private-rt"
    }
}

