variable "aws_region" {
  description = "The AWS region to use"
  default     = "ap-south-1" # Mumbai region
}

variable "instance_type" {
  description = "The EC2 instance type to use for the Strapi server"
  default     = "t3.small"
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances"
  default     = "strapi-key" # Read the key name from a file
}

variable "public_key_path" {
  description = "The path to the public key file for the SSH key pair"
  default     = "strapi-key.pub" # Path to the public key file
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  default     = "ami-019715e0d74f695be" # Amazon Linux 2 AMI (HVM), SSD Volume Type  
}
