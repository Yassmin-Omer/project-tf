terraform {
  backend "s3" {
    bucket = "remote_bucket"
    key    = "remote-backend"
    region = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}


#create dynamodb
resource "aws_dynamodb_table" "terraform_lock" {
  name           = "TerraformLockTable"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  attribute {
    name = "IsLocked"
    type = "BOOL"
  }
}  