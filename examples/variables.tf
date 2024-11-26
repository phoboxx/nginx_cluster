variable "ssh_public_key" {
  type = string
  default = "FAKE PUBLIC KEY"
}

variable "aws_2023_ami" {
  type = string
  default = "ami-050cd642fd83388e4"
}

variable "ec2_type" {
  type = string
  default = "t2.micro"
}