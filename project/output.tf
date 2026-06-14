output "ec2_public_ip" {
  value = module.ec2.instance_public_ip
}
output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_ami" {
  value = module.ec2.instance_ami
}

output "ec2_subnet_id" {
  value = module.ec2.instance_subnet_id
}

output "s3_bucket_name" {
  value = module.s3_bucket.aws_s3_bucket_name
}
output "s3_bucket_arn" {
  value = module.s3_bucket.s3_bucket_arn

}
output "s3_bucket_id" {
  value = module.s3_bucket.s3_bucket_id

}

output "s3_bucket_versioning_status" {
  value = module.s3_bucket.s3_bucket_versioning_status

}
output "s3_bucket_object_lock" {
  value = module.s3_bucket.s3_bucket_object_lock_status

}