variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"

}
###################################################################
variable "aws_vpc_name" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "test_vpc"

}

####################################################################
variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

#####################################################################
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.16.0/24"

}

#####################################################################
variable "public_subnet_az" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = "us-east-1b"

}
#####################################################################
variable "private_subnet_az" {
  description = "Availability zone for the private subnet"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]

}
######################################################################
variable "aws_sg_ingress" {
  description = "Security group ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "ssh access"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["152.58.182.49/32"] # Replace with your IP address
    },
    {
      description = "http access"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "https access"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
######################################################################
variable "aws_sg_egress" {
  description = "Security group ingress rules for private subnet"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"          # All protocols
      cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
    }
  ]


}
########################################################################
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"

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
#######################################################################
