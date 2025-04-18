output "s3_bucket_arn" {
	value		= aws_s3_bucket.terraform_state.arn
	description	= "ARN of the s3 bucket"
}

output "dynamodb_table_name" {
	value		= aws_dynamodb_table.terraform_locks.name
	description	= "Name of the dynamodb table"
}
