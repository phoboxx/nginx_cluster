output "nginx_dns" {
  value = aws_instance.nginx.public_dns
  
}

output "ssh" {
  value = "ssh -i [SSH_KEY_FILE] ec2-user@${aws_instance.nginx.public_dns}"
}
