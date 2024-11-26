# NOTE: We are referencing outputs from the nginx_cluster module
# This is called module composition
# we are not referencing module.nginx_cluster.aws_instance.nginx.public_dns we are referencing its OUTPUT from modules/nginx_cluster/outputs.tf

output "nginx_dns" {
  value = module.nginx_cluster.nginx_dns
  
}

output "ssh" {
  value = module.nginx_cluster.ssh
}
