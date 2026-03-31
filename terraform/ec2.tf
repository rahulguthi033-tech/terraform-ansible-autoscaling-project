resource "aws_instance" "web_instance" {
  ami                         = "ami-0f58b397bc5c1f2e8"
  instance_type               = "t2.micro"
  key_name                    = "my-keypair"
  subnet_id                   = aws_subnet.public_subnet_az1.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "<h1>Hello from Terraform in ap-south-1a!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-server-az1"
  }
}

