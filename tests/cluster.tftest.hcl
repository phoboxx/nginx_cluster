variables {
    aws_2023_ami = "ami-050cd642fd83388e4"
    ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjOu4yEbu61rf9ghY3pDHGwCCTsUnT1h87WUTKh1Q6Y"
    ec2_type = "t2.micro"
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}


run "input_validation" {
    
    command = plan

    variables {
        aws_2023_ami = "Invalid AMI"
        ssh_public_key = "Invalid ssh key"
        ec2_type = "Invalid EC2 instance"
    }

    expect_failures = [ var.aws_2023_ami, var.ssh_public_key ]
}

run "aws_instance_nginx_validation" {
    command = plan

    assert {
        condition = aws_instance.nginx.ami == var.aws_2023_ami
        error_message = "failure"
    }

    assert {
        condition = aws_instance.nginx.instance_type == var.ec2_type
        error_message = "failure"
    }

    assert {
        condition = aws_instance.nginx.key_name == "user_1"
        error_message = "failure"
    }

    assert {
      condition = aws_instance.nginx.user_data != ""
      error_message = "failure"
    }
}


run "aws_security_group_rule_allow_http_validation" {
    command = plan

    assert {
      condition = aws_security_group_rule.allow_http.type == "ingress"
      error_message = "failure"
    }

    assert {
      condition = aws_security_group_rule.allow_http.from_port == 80
      error_message = "failure"
    }

    assert {
      condition = aws_security_group_rule.allow_http.to_port == 80
      error_message = "failure"
    }

    assert {
      condition = aws_security_group_rule.allow_http.protocol == "tcp"
      error_message = "failure"
    }
    
    assert {
      condition = length(aws_security_group_rule.allow_http.cidr_blocks) == 1
      error_message = "failure"
    }

    assert {
      condition = aws_security_group_rule.allow_http.cidr_blocks[0] == "0.0.0.0/0"
      error_message = "failure"
    }
}

# run "tag_validation" {

# }

# Integration tests

# run "apply_setup" {

#     variables {
#         aws_2023_ami = "ami-050cd642fd83388e4"
#         ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjOu4yEbu61rf9ghY3pDHGwCCTsUnT1h87WUTKh1Q6Y"
#         ec2_type = "t2.micro"
#     }

#     assert {
#         condition = output.nginx_dns != ""
#         error_message = "The DNS name is not returned"
#     }
# }