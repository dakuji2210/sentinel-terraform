output "vpc_name" {
  value = aws_vpc.test_vpc.tags["Name"]

}

output "private_subnet_names" {
  value = [for i in aws_subnet.test_subnet_private : i.tags["Name"]]
}

output "private_subnet_availability_zones" {
  value = [for i in aws_subnet.test_subnet_private : i.availability_zone]
}
output "private_subnet_cidrs" {
  value = [for subnet in aws_subnet.test_subnet_private : subnet.cidr_block]
}

output "public_subnet_name" {
  value = aws_subnet.test_subnet_public.tags["Name"]
}

output "public_subnet_cidr" {
  value = aws_subnet.test_subnet_public.cidr_block
}

output "public_subnet_availability_zone" {
  value = aws_subnet.test_subnet_public.availability_zone
}
output "internet_gateway_name" {
  value = aws_internet_gateway.test_igw.tags["Name"]
}

output "internet_gateway_name_id" {
  value = aws_internet_gateway.test_igw.id
}

output "public_route_table_name" {
  value = aws_route_table.test_route_table_public.tags["Name"]
}

output "private_route_table_name" {
  value = aws_route_table.test_route_table_private.tags["Name"]
}

output "public_route_table_id" {
  value = aws_route_table.test_route_table_public.id
}

output "private_route_table_id" {
  value = aws_route_table.test_route_table_private.id
}

output "ec2_instance_id" {
  value = aws_instance.test_instance.id
}

output "ec2_instance_public_ip" {
  value = aws_instance.test_instance.public_ip
}

output "ec2_instance_private_ip" {
  value = aws_instance.test_instance.private_ip
}

output "ec2_instance_ami_id" {
  value = aws_instance.test_instance.ami
}

output "ec2_instance_type" {
  value = aws_instance.test_instance.instance_type
}

output "ec2_instance_key_name" {
  value = aws_instance.test_instance.key_name
}

output "ec2_instance_security_groups" {
  value = aws_instance.test_instance.security_groups
}

output "ec2_instance_subnet_id" {
  value = aws_instance.test_instance.id
}

