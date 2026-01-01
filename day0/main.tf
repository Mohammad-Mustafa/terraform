resource "aws_instance" "name"{
 ami = var.ami_id
 instance_type = var.type
 subnet_id = var.subnet_id
}