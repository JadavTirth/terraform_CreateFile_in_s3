resource "aws_s3_bucket" "remote_s3" {
  bucket = "jadav-bucket-terraform-12345"

  tags = {
    Name        = "jadav-bucket"
    Environment = "Dev"
  }
}
