terraform {
  backend "s3" {
    bucket = "tfstatefilebucketday4"
    key    = "bucket01"
    region = "ca-central-1"
    # state file locking code
    #use_lockfile = true
    dynamodb_table = "dynamoforstatelockingnots3"
  }
}
