# TODO: Create Security Group Allowing HTTP traffic
# TODO: Create Security Group Allowing SSH traffic
# TODO: Create user_data script 
# TODO: Import SSH key
# TODO: EC2 instance -> Public IP address
# TODO: outputs


resource "aws_instance" "nginx" {
  ami           = var.aws_2023_ami
  instance_type = var.ec2_type
  security_groups = [aws_security_group.allow_http.name, aws_security_group.allow_ssh.name, aws_security_group.allow_all_egress.name]
  key_name = aws_key_pair.user_1.key_name
  user_data = file("${path.module}/scripts/install_nginx.sh")

  tags = {
    Name = "nginx"
  }
}

resource "aws_security_group" "allow_http" {
  name = "ALLOW_HTTP"
}

resource "aws_security_group" "allow_ssh" {
  name = "ALLOW_SSH"
}

resource "aws_security_group" "allow_all_egress" {
  name = "ALLOW_ALL_EGRESS"
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_http.id
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_http.id
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_all_egress.id
}

resource "aws_key_pair" "user_1" {
  key_name = "user_1"
  public_key = var.ssh_public_key
}
