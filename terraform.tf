# To configure aws access using SSO you may use below link from percona documentation:
# https://www.notion.so/percona/AWS-Accessing-AWS-through-CLI-d5affcb773104794b637c1217c5d0c20?pvs=4

provider "aws" {
  profile = "sso-aws-gs-sandbox-engineer-482433642182"    # Regular engineer access profile.
   #profile = "AdministratorAccess-562648626458"          # Admin access ( Use if needed Elastic IP) 
}



# Generate inventory file 
resource "local_file" "inventory" {
 filename = "./Ansible/hosts"
 content = <<EOF
[kuber-plane]
${aws_instance.kuber_control_plane_denis.public_ip}
[kuber-worker]
${aws_instance.kuber_worker_node_denis[0].public_ip}
${aws_instance.kuber_worker_node_denis[1].public_ip}
EOF
}

## Once Instance is ready let's run ansible playbook command over it

resource "null_resource" "ansiblePlaybook" {
  
 provisioner "local-exec" {
    command =  "ansible-playbook -i ./Ansible/hosts ./Ansible/k8s_primary.yaml"
  }
# Below dependency needs to start running ansible scrip once instance is ready to use 
depends_on = [ local_file.inventory]
}
 ## terraform apply -auto-approve 
 ## terraform destroy -auto-approve 