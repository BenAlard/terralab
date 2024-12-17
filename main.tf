provider "aws" {
	region = "eu-west-1"
}

resource "aws_instance" "example" {
	ami 		= "ami-03cc8375791cb8bcf"
	instance_type 	= "t2.micro"


tags = {
	Name = "terraform.example"
	}
}
