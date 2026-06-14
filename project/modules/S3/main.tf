resource "aws_s3_bucket" "mybucket" {
    bucket = var.bucket_name
    object_lock_enabled = true
}

resource "aws_s3_bucket_versioning" "mybucket" {
    bucket = aws_s3_bucket.mybucket.id

    versioning_configuration {
        status = "Enabled"
    }
}
