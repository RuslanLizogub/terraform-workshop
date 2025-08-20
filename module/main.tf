module "backend_dev" {
  source = "../resources"
  instance_type = "t4g.micro"
}

module "backend_test" {
  source = "../resources"
  instance_type = "t4g.micro"
  tags = {
    Name = "tf-web-test-arm"
    Environment = "test"
  }
}

module "backend_prod" {
  source = "../resources"
  tags = {
    Name = "tf-web-prod-arm"
    Environment = "prod"
  }
}

terraform {
  backend "s3" {
    bucket         = "tf-state-960585837301-eu-north-1"  # your S3 bucket for state
    key            = "tfstate/eu-north-1.tfstate"        # path/file in the bucket
    region         = "eu-north-1"
    profile        = "tf"
    use_lockfile     = true
  }
}