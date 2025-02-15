# Create an Internet-Facing Load Balancer
resource "aws_lb" "http_lb" {
  name               = "http-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.http_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}

# Target Group for the Load Balancer
resource "aws_lb_target_group" "http_tg" {
  name     = "http-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Load Balancer Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.http_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http_tg.arn
  }
}