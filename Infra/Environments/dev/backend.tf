terraform {
  backend "s3" {
    bucket         = "nsh-terraform-demo-bucket"  
    key            = "eks-monitoring/staging/terraform.tfstate"
    region         = "us-east-1"            
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}


