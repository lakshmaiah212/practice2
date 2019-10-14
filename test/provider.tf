provider "aws" {}

terraform {
  backend "s3" {
    bucket = "lakshmaiahaws.xyz"
    key    = "terraformpractice2/test/terraform.tfstate"
    region = "us-east-1"
  }
}