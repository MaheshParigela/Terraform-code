output "instance_public_ip" {
  value = aws_instance.webserver.public_ip
}
output "instance_id" {
  value = aws_instance.webserver.id
}
output "instance_ami" {
  value = aws_instance.webserver.ami
}
output "instance_subnet_id" {
  value = aws_instance.webserver.subnet_id
} 