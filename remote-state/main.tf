provider "aws" {
  region = "eu-west-2"
  profile= "Muna"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "ikenna-k8s-tfstate"
     
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.terraform_state.id

    versioning_configuration {
      status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "k8s-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "ikeID"

  attribute {
    name = "ikeID"
    type = "S"
  }
}