resource "aws_vpc" "strapi_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "strapi-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.strapi_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "strapi-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.strapi_vpc.id

  tags = {
    Name = "strapi-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.strapi_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "strapi-public-route-table"
  }
}

resource "aws_route_table_association" "public_assoc" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public.id
}
