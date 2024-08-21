
resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg1"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
   health_check {
    path                = "/login"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}
resource "aws_lb_listener" "redirect" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:acm:ap-southeast-1:621573549101:certificate/ba99ab91-2d4e-4df8-aa04-eaac6300fc7e"

  default_action {
    # type = "redirect"
    # redirect {
    #   port = "443"
    #   protocol = "HTTPS"
    #   status_code = "HTTP_301"
    type = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.test.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:acm:ap-southeast-1:621573549101:certificate/ba99ab91-2d4e-4df8-aa04-eaac6300fc7e"

#   default_action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.test.arn
#   }
# }
