provider "aws" {
  region = "eu-north-1"
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
}

resource "aws_instance" "teruarc2-2" {
  ami ="ami-064087b8d355e9051"
  instance_type = "t3.nano"
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = "terraform-is-up"
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "It really works, my friend!" > index.html
    nohup busybox httpd -f -p 8080 &
    EOF
  
  user_data_replace_on_change = true

  credit_specification {
    cpu_credits = "standard"
  }
}
