variable "server_port" {
	description = "Port used by server for HTTP resources"
	type = number
	default = 8080
}

variable "cluster_name" {
	description	= "Name to use for all cluster resources"
	type		= string
}

variable "db_remote_state_bucket" {
	description	= "Name of the db's remote state bucket"
	type		= string
}

variable "db_remote_state_key" {
	description	= "Path to the db's remote state in s3"
	type		= string
}
