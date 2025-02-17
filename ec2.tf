# Security Group for HTTP access
resource "aws_security_group" "http_sg" {
  name        = "http-security-group"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch Template for EC2 Instances
resource "aws_launch_template" "http_template" {
  name_prefix   = "http-server-"
  image_id      = var.ami_id  # Amazon Linux 2 (update as needed)
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.http_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Hello world from the - $(hostname)</h1>" | sudo tee /var/www/html/index.html
EOF
  )
}

# Auto Scaling Group with 3 EC2 Instances
resource "aws_autoscaling_group" "http_asg" {
  desired_capacity     = 3
  max_size            = 3
  min_size            = 3
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]  # Attach to subnets

  launch_template {
    id      = aws_launch_template.http_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.http_tg.arn]
}
