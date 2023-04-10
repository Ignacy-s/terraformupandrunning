provider "aws" {
  region = "eu-north-1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

output "public_ip" {
  value        = aws_instance.teruarc2-3.public_ip
  description  = "The public IP address of the web server"
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
}

resource "aws_instance" "teruarc2-3" {
  ami ="ami-064087b8d355e9051"
  instance_type = "t3.nano"
  vpc_security_group_ids = [aws_security_group.instance.id]
  tags = {
    Name = "terraform-is-up"
  }

  user_data = <<-EOF
    #!/bin/bash
    echo "It really works, my friend!" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF
  
  user_data_replace_on_change = true

  credit_specification {
    cpu_credits = "standard"
  }
}

