provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc-1"
  }
}

resource "aws_security_group" "web-sg" {
  name        = "exercise2-sg"
  description = "Web Tier Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_subnet" "web-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.31.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "web-1a-subnet"
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-0aeeebd8d2ab47354"
  instance_type               = "t2.micro"
  private_ip                  = "172.31.1.21"
  vpc_security_group_ids      = [aws_security_group.web-sg.id]
  subnet_id                   = aws_subnet.web-1a.id
  key_name                    = "chukky"
  associate_public_ip_address = "true"
  user_data                   = file("run-flask.sh")
  tags = {
    Name = "web-1"
  }
}

resource "aws_route_table_association" "web-route-a" {
  subnet_id      = aws_subnet.web-1a.id
  route_table_id = aws_route_table.webapp-rt.id
}

resource "aws_route_table" "webapp-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.webapp-igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.webapp-igw.id
  }

  tags = {
    Name = "webapp-rt"
  }
}

resource "aws_internet_gateway" "webapp-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "webapp-igw"
  }
}

output "ec2-public-ip" {
  value = "http://${aws_instance.web.public_ip}"
}