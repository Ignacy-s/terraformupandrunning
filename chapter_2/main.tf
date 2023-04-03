provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "teruarc2-2" {
  ami ="ami-064087b8d355e9051"
  instance_type = "t3.nano"

  tags = {
    Name = "terraform-is-up"
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "Hello World!" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF
  
  user_data_replace_on_change = true

  credit_specification {
    cpu_credits = "standard"
  }
}
