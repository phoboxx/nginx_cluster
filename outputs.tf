output "nginx_dns" {
  value = aws_instance.nginx.public_dns

}

output "ssh" {
  value = "ssh -i [SSH_KEY_FILE] ec2-user@${aws_instance.nginx.public_dns}"
}

output "test_output_version_1_0_1" {
  value = "This is a test for version 1.0.1"
}
