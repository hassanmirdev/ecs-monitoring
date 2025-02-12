terraform{
  backend "s3" {
    bucket         = "nsh-state-new"
    key            = "dev/terraform/key/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}



