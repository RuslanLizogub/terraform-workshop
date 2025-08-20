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