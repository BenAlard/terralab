provider "aws" {
	region = "eu-west-1"
}

variable "server_port" {
	description = "Port used by server for HTTP resources"
	type = number
	default = 8080
}

output "public_ip" {
	value = aws_instance.example.public_ip
	description = "Public IP of the webserver"
}

resource "aws_security_group" "instance" {
	name = "terraform-example-instance"
	ingress {
		from_port = var.server_port
		to_port = var.server_port
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_launch_configuration" "example" {
	image_id 		=	"ami-03cc8375791cb8bcf"
	instance_type 	=	"t2.micro"
	security_groups =	[aws_security_group.instance.id]
	user_data	=	<<-EOF
				#!/bin/bash
				echo "Hello, World" > index.html
				nohup busybox httpd -f -p ${var.server_port} &
				EOF
	user_data_replace_on_change = true
	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_autoscaling_group" "example" {
	launch_configuration = aws_launch_configuration.example.name

	min_size = 2
	max_size = 10

	tag {
		key = "Name"
		value = "terraform-asg-example"
		propagate_at_launch = true
		}
	}

tags = {
	Name = "terraform.example"
	}
}

