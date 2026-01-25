resource aws_instance name{
     ami = "ami-085f043560da76e08"
    instance_type = "t3.micro"
    user_data_base64 = file("file.sh")
    tags = {
      name ="user_data"
    }
}