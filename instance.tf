# aws instance create 
resource "aws_instance" "ins1" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = "jenkins-key-2"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.security2.id,aws_security_group.test2.id]
  subnet_id                   = aws_subnet.subnet1a.id
  tags = {
      Name = "ALB-EC2-1"
  }
}

# aws instace create 
resource "aws_instance" "ins2" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = "jenkins-key-2"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.test2.id,aws_security_group.security2.id]
  subnet_id                   = aws_subnet.subnet2b.id
  tags = {
      Name = "ALB-EC2-2"
  }
}
resource "aws_instance" "ins3" {
  ami           = var.instance_ami
  instance_type = "t2.medium"
  key_name      = "jenkins-key-2"
  #associate_public_ip_address = "true"
  vpc_security_group_ids = [aws_security_group.security2.id,aws_security_group.test2.id]
  subnet_id              = aws_subnet.subnet3a.id
  tags = {
      Name = "ALB-EC2-Private"
  }
   

}

# aws instace create 
