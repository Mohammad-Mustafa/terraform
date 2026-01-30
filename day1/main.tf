
resource "aws_instance" "namee"{
    ami = "ami-085f043560da76e098"
    instance_type = "t3.small"
    subnet_id = "subnet-097b15f1752cc402d"
  
}
