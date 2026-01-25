provider "aws" {
  
}

resource "aws_instance" "name" {
  ami = "ami-085f043560da76e08"
  instance_type = "t3.micro"

  tags = {
    Name = "Workspace"
  }
}
