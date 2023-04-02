provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "teruarc2-1" {
  ami ="ami-064087b8d355e9051"
  instance_type = "t3.nano"

  tags = {
    Name = "terraform-is-up"
  }

  credit_specification {
    cpu_credits = "standard"
  }
}
