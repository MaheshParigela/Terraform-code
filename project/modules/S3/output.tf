output "aws_s3_bucket_name" {
    value = aws_s3_bucket.mybucket.bucket

}
output "s3_bucket_arn" {
    value = aws_s3_bucket.mybucket.arn

}
output "s3_bucket_id" {
    value = aws_s3_bucket.mybucket.id

}
output "s3_bucket_versioning_status" {
    value = aws_s3_bucket_versioning.mybucket.versioning_configuration.0.status
}
output "s3_bucket_object_lock_status" {
    value = aws_s3_bucket.mybucket.object_lock_enabled

}