# Key Pair
# -------------------------------
resource "aws_key_pair" "deploy" {
  key_name   = "terra-ec2"
  public_key = file("terra-ec2.pub")
}

# -------------------------------
# Default VPC
# -------------------------------
resource "aws_default_vpc" "default" {}

# -------------------------------
# Security Group
# -------------------------------
resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "this is my security"
  vpc_id      = aws_default_vpc.default.id

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # change to your IP for security
    description = "ssh open"
  }

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http open"
  }

  # Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
  }

  tags = {
    Name = "automate-sg"
  }
}

# -------------------------------
# Get Latest Amazon Linux 2 AMI
# -------------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# -------------------------------
# EC2 Instance
# -------------------------------
resource "aws_instance" "my_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deploy.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }

  tags = {
    Name = "First_Automate"

  }
}


