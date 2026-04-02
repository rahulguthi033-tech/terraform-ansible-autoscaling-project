resource "aws_launch_template" "web" {
  name_prefix   = "rahul-template"
  image_id      = "ami-0f58b397bc5c1f2e8"
  instance_type = var.instance_type

  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.web_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
  )
}
