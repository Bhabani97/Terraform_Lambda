terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIAX6GPFQQI4WLULYJT"
  secret_key = "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"
}