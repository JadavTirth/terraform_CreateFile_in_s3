  resource "aws_dynamodb_table" "basic-dynamodb-table" {
    name           = "my_table"
    billing_mode   = "PAY_PER_REQUEST"  # PROVISIONED -> monthly bill and  PAY_PER_REQUEST -> per req.
    hash_key       = "LockID"


    attribute {
      name = "LockID"
      type = "S"
    }

    

    tags = {
      Name        = "my_table"
    }
  }