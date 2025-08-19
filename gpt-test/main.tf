terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "eu-north-1"   # твой регион
  profile = "tf"           # имя SSO-профиля из aws configure sso
}

data "aws_caller_identity" "me" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

output "whoami" {
  value = {
    account  = data.aws_caller_identity.me.account_id
    arn      = data.aws_caller_identity.me.arn
    region   = data.aws_region.current.name
    partition= data.aws_partition.current.partition
  }
}