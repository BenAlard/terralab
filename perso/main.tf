provider "aws" {
    region = "eu-west-1"
}

terraform {
    backend "s3" {
        bucket         = "terraform-up-and-running-state-bal"
        key            = "perso/s3/terraform.tfstate"
        region         = "eu-west-1"
        dynamodb_table = "terraform-up-and-running-locks"
        encrypt        = true
    }
}

# Create a security group
resource "aws_security_group" "allow_ssh" {
    name        = "allow_ssh"
    description = "Allow SSH inbound traffic"
    
    ingress {
        description = "SSH from anywhere"
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
}

# Create the EC2 instance
resource "aws_instance" "ubuntu_instance" {
    ami           = "ami-0d64bb532e0502c46"
    instance_type = "t2.micro"
    key_name      = "bal"  # Make sure this matches your existing key pair name
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    
    tags = {
        Name = "Ubuntu-Instance"
    }
}

# Output the public IP
output "public_ip" {
    value = aws_instance.ubuntu_instance.public_ip
}
