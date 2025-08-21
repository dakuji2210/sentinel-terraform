variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"

}

variable "aws_vpc_name" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "test_vpc"
  
}


variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.16.0/24"

}

variable "public_subnet_az" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = "us-east-1b"

}
variable "private_subnet_az" {
  description = "Availability zone for the private subnet"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]

}

variable "aws_sg_ingress" {
  
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"

}
variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-020cba7c55df1f615" # Replace with a valid AMI ID for your region

}

variable "instance_key_name" {
  description = "Key pair name for the EC2 instance"
  type        = string
  default     = "test_instance" # Replace with your key pair name

}
