provider "aws" {
	region = "eu-west-1"
}

terraform {
	backend "s3" {
		bucket	= "terraform-up-and-running-state-bal"
		key	= "workspaces-example/terraform.tfstate"
		region	= "eu-west-1"

	dynamodb_table	= "terraform-up-and-running-locks"
	encrypt		= true
	}
}

resource "aws_instance" "example" {
	ami		= "ami-0d64bb532e0502c46"
	instance_type	= "t2.micro"
}
