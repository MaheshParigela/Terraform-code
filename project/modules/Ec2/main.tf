resource "aws_instance" "webserver" {
     ami =var.ami
     subnet_id =var.subnet_id
     instance_type = var.instance_type
         tags ={
        Name =var.name
     }
  
}