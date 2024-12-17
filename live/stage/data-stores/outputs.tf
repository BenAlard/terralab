output "address" {
	value		= aws_db_instance.example.address
	description	= "Connect at this endpoint"
}

output "port" {
	value		= aws_db_instance.example.port
	description	= "DB listening on"
}
