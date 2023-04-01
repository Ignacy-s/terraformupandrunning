provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "teruarc2-1" {
  ami =
  instance_type = "t2.micro"
}
