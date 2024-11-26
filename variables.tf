variable "ssh_public_key" {
  type = string

  validation {
    condition = startswith(var.ssh_public_key, "ssh-")
    error_message = "failure"
  }
}

variable "aws_2023_ami" {
  type = string

  validation {
    condition = length(var.aws_2023_ami) > 4 && substr(var.aws_2023_ami, 0, 4) == "ami-"
    error_message = "failure"
  }
}

variable "ec2_type" {
  type = string
}
