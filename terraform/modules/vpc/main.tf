resource "aws_vpc" "this" {
  # Enable VPC DNS so internal AWS service names resolve correctly.
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "public" {
  # Public subnets host internet-facing network components such as NAT.
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_b_cidr_block
  availability_zone       = var.public_availability_zone_b
  map_public_ip_on_launch = true
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.id
}

resource "aws_route_table_association" "public_b" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_b.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  # Keep private subnet A's outbound path in the same Availability Zone.
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  depends_on = [aws_internet_gateway.this]
}

resource "aws_eip" "nat_b" {
  domain = "vpc"
}

resource "aws_nat_gateway" "b" {
  # A second NAT keeps Availability Zone B independently routable.
  allocation_id = aws_eip.nat_b.id
  subnet_id     = aws_subnet.public_b.id

  depends_on = [aws_internet_gateway.this]
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_a_cidr_block
  availability_zone = var.private_availability_zone_a
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_b_cidr_block
  availability_zone = var.private_availability_zone_b
}

resource "aws_route_table" "private" {
  # Private workloads use NAT only for controlled outbound access.
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = var.public_route_cidr_block
    nat_gateway_id = aws_nat_gateway.this.id
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = var.public_route_cidr_block
    nat_gateway_id = aws_nat_gateway.b.id
  }
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_a.id
}

resource "aws_route_table_association" "private_b" {
  route_table_id = aws_route_table.private_b.id
  subnet_id      = aws_subnet.private_b.id
}
