provider "aws" {
	region	= "eu-west-1"
}

resource "aws_db_instance" "example" {
	identifier_prefix	= "terraform-up-and-running"
	engine			= "mysql"
	allocated_storage	= 10
	instance_class		= "db.t3.micro"
	skip_final_snapshot	= true
	db_name			= "example_database"

	username		= var.db_username
	password		= var.db_password
}

terraform {
	backend "s3" {
		bucket	= "terraform-up-and-running-state-bal"
		key	= "stage/data-stores/mysql/terraform.tfstate"
		region	= "eu-west-1"

	dynamodb_table	= "terraform-up-and-running-locks"
	encrypt		= true
	}
}

resource "aws_security_group_rule" "allow_testing_inbound" {
	type			= "ingress"
	security_group_id	= module.webserver_cluster.alb_security_group_id

	from_port	= 12345
	to_port		= 12345
	protocol	= "tcp"
	cidr_blocks	= ["0.0.0.0/0"]
}
