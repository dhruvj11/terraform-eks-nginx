terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # Use AWS provider v5.x to match module v20.x until module is upgraded to v21+
      version = ">= 5.40.0, < 6.0.0"
    }
  }
}