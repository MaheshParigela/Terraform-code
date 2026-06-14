provider "aws" {
  region = "ap-south-2"
}

module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}
module "ec2" {
  source        = "./modules/Ec2"
  ami           = var.ami
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
    name          = var.name
}