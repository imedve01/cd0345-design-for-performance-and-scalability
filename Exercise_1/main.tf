# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region = "us-east-1"
}

variable "existing_vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "existing_public_subnet_id" {
  description = "The ID of the existing public subnet"
  type        = string
}

resource "aws_security_group" "allow_ssh" {
  vpc_id = var.existing_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH from any IP (adjust for security)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow SSH"
  }
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity_t2" {
  count         = 4
  ami           = "ami-0fff1b9a61dec8a5f"
  instance_type = "t2.micro"
  subnet_id     = var.existing_public_subnet_id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Udacity T2"
  }

  # Enable connection via SSH
  key_name = "udacity"
}

