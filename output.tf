output "My_instance_public_ip" {
  value= aws_instance.denis_test_instance_terraform.public_ip
}