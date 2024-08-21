# aws vpc create 
resource "aws_vpc" "vpc1" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
      Name = "ALB-VPC"
  }

}

# create aws vpc subnet1 a
resource "aws_subnet" "subnet1a" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = "true"
  tags = {
      Name = "subnet-ALB-1"
  }
}

# create aws vpc subnet2 b
resource "aws_subnet" "subnet2b" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = "true"
  tags = {
      Name = "subnet-ALB-2"
  }
}

# create aws vpc subnet3 a
resource "aws_subnet" "subnet3a" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
      Name = "subnet-ALB-3"
  }
}

# create aws vpc subnet4 b
resource "aws_subnet" "subnet4b" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
      Name = "subnet-ALB-4"
  }
}


# create internet gateway in vpc 
resource "aws_internet_gateway" "vpc1_igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpcigw"
  }
}

# create a route table public 
resource "aws_route_table" "Public_RT" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1_igw.id
  }

  tags = {
    Name = "default_route_table_association"
  }
}

# associate subnet1a with Public_RT table
resource "aws_route_table_association" "subnet1a_rt" {
  subnet_id      = aws_subnet.subnet1a.id
  route_table_id = aws_route_table.Public_RT.id
}

# associate subnet2b with Public_RT table
resource "aws_route_table_association" "subnet2b_rt" {
  subnet_id      = aws_subnet.subnet2b.id
  route_table_id = aws_route_table.Public_RT.id
}

#creating nat elastic ip for gatway 

resource "aws_eip" "nat-eip" {
  depends_on = [aws_internet_gateway.vpc1_igw]
  tags = {
    "name" = "Nat gateway eip"
  }
}

# creating NAT gateway for rds 
resource "aws_nat_gateway" "testNAT" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.subnet1a.id
  tags = {
    Name = "testNAT"
  }
}

resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.testNAT.id
  }

  tags = {
    Name = "privateroute"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnet3a.id
  route_table_id = aws_route_table.privateroute.id
}
resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.subnet4b.id
  route_table_id = aws_route_table.privateroute.id
}