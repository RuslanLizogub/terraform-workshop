provider "aws" {
  region  = "eu-north-1"
  profile = "tf"
}

resource "aws_instance" "web" {
  ami           = data.aws_ssm_parameter.al2023_arm.value
  instance_type = "t4g.nano"  # Graviton
  tags = { Name = "tf-web-arm" }
}

data "aws_ssm_parameter" "al2023_arm" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-arm64"
}

resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  tags = { Name = "tf-web-arm-eip" }
}