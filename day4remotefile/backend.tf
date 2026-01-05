terraform {
  backend "s3" {
    bucket = "tfstatefilebucketday4"
    key    = "bucket01"
    region = "ca-central-1"
  }
}