resource aws_instance name{
     ami = "ami-085f043560da76e08"
    instance_type = "t3.micro"
    subnet_id = "subnet-097b15f1752cc402d"
    tags = {
      name ="S3 usefile=true"
    }
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "tfstatefilebucketday4"

  tags = {
    Name        = "bucket01"
    Environment = "test"
  }
}