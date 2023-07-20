
# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.cidr
}

# Create subnets
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr
}

resource "aws_subnet" "database" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr
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
    cidr_blocks = var.cidr
  }
}
# Launch EC2 instances
resource "aws_instance" "public" {
  ami = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public.id]
}

resource "aws_instance" "private" {
  ami = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private.id]
}

resource "aws_instance" "database" {
  ami = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.database.id
}
