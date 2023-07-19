# Configure the AWS provider
provider "aws" {
  access_key = "AKIATXQE4DXOTAMTNFEF"
  secret_key = "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"
  region = "ap-south-1"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "14.0.0.0/16"
}

# Create subnets
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "14.0.1.0/24"
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "14.0.2.0/24"
}

resource "aws_subnet" "database" {
  vpc_id = aws_vpc.main.id
  cidr_block = "14.0.3.0/24"
}

# Create security groups
resource "aws_security_group" "public" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "private" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["14.0.1.0/24"]
  }
}

# Launch EC2 instances
resource "aws_instance" "frontend" {
  ami = "ami-06875f9a6b98d295f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public.id]
}

resource "aws_instance" "backend" {
  ami = "ami-06875f9a6b98d295f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private.id]
}

resource "aws_instance" "database" {
  ami = "ami-06875f9a6b98d295f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.database.id
}
