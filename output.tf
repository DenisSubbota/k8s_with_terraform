output "control_plane_public_ip" {
  value= aws_instance.kuber_control_plane_denis.public_ip
}
output "worker_node0_public_ip" {
  value= aws_instance.kuber_worker_node_denis[0].public_ip
}
output "worker_node1_public_ip" {
  value= aws_instance.kuber_worker_node_denis[1].public_ip
}