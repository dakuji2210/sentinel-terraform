
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}


resource "aws_vpc" "multi_vpc" {
  for_each = { for vpc in var.vpcs : vpc.name => vpc }

  cidr_block           = each.value.cidr
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  tags                 = each.value.tags
}

resource "aws_subnet" "test_subnet_private" {

  count                   = length(var.private_subnet_cidr)
  vpc_id                  = aws_vpc.multi_vpc[0].id # Use the first VPC in the list
  cidr_block              = var.private_subnet_cidr[count.index] # Use the availability zone from the variable or default to the first AZ
  availability_zone       = var.private_subnet_az[count.index]
  map_public_ip_on_launch = false
  tags = {

    Name = "test_subnet{count.index + 1}_private"
  }
}

resource "aws_subnet" "test_subnet_public" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_subnet_az
  map_public_ip_on_launch = true
  tags = {
    Name = "test_subnet_public"
  }

}


resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "test_igw"
  }


}

resource "aws_route_table" "test_route_table_public" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id

  }
  tags = {
    Name = "test_route_table_public"
  }
}
resource "aws_route_table" "test_route_table_private" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "test_route_table_private"
  }
}

resource "aws_route_table_association" "test_route_table_association_public" {
  subnet_id      = aws_subnet.test_subnet_public.id
  route_table_id = aws_route_table.test_route_table_public.id
}
resource "aws_route_table_association" "test_route_table_association_private" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.test_subnet_private[count.index].id
  route_table_id = aws_route_table.test_route_table_private.id
}

resource "aws_eip" "test_nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }

}



resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.test_nat_eip.id
  subnet_id     = aws_subnet.test_subnet_public.id # Must be a public subnet
  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_security_group" "test_sg" {
  name        = "test_sg"
  description = "Security group for test VPC"
  vpc_id      = aws_vpc.test_vpc.id

  dynamic "ingress" {
    for_each = var.aws_sg_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks

    }


  }
  dynamic "egress" {
    for_each = var.aws_sg_egress
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }

  }
  tags = {
    Name = "test_sg"
  }
}

resource "aws_instance" "test_instance" {
  ami                         = var.ec2_ami_id # Replace with a valid AMI ID for your region
  instance_type               = var.ec2_instance_type
  key_name                    = var.instance_key_name # Replace with your key pair name
  subnet_id                   = aws_subnet.test_subnet_public.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.test_sg.id]
  tags = {
    Name = "test_instance"
  }
}