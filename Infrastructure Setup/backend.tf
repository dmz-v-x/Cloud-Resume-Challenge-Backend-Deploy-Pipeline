terraform {
  backend "s3" {
    bucket         = "cloud-resume-challenge-backend"
    key            = "terraform.tfstate"
    region         = "ap-south-1"  
    encrypt        =  true
    dynamodb_table = "terraform-state-lock"
  }
}