provider "aws" {
  region = "eu-north-1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

# This method of getting public ip doesn't work with ASG
# output "public_ip" {
#   value        = aws_autoscaling_group.example.public_ip
#   description  = "The public IP address of the web server"
# }

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "examplenton" {
  image_id ="ami-064087b8d355e9051"
  instance_type = "t3.nano"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
    #!/bin/bash
    echo "It really works, my friend!" > index.html
    nohup busybox httpd -f -p ${var.server_port} &
    EOF
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.examplenton.name

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}
