variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string

}
variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}
variable "subnet_id" {
  description = "The subnet ID for the EC2 instance"
  type        = string

}
variable "name" {
  description = "The name tag for the EC2 instance"
  type        = string

}
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

}