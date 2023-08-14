# To configure aws access using SSO you may use below link from percona documentation:
# https://www.notion.so/percona/AWS-Accessing-AWS-through-CLI-d5affcb773104794b637c1217c5d0c20?pvs=4

provider "aws" {

  profile = "sso-aws-gs-sandbox-engineer-482433642182"    # Regular engineer access profile.
   #profile = "AdministratorAccess-562648626458"          # Admin access ( Use if needed Elastic IP) 
}

# Create a public key on the AWS 
resource "aws_key_pair" "denis_pub_key" {
	key_name = "denis_pub_key"
	public_key = "${file("denis_ssh_key.pub")}"
}

#Creating single ec2 instance
resource "aws_instance" "denis_test_instance_terraform" {
    ami = "ami-0261755bbcb8c4a84"       # Ubuntu 20 
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public_subnet_denis.id #were needed for vpc.tf and nat.tf 
    vpc_security_group_ids = [ aws_security_group.k8s_security_group.id ]
    key_name = "denis_pub_key"
## IMPORTANT: All Provisioners are running only over freshly created instances, and if you updated provisioner you need to destroy and create env again.
## Work-around to verify that instance accessable through ssh  
    provisioner "remote-exec" {
        inline = ["echo 'Wait untill SSH is ready' "]
        connection{
            type = "ssh"
            user = "ubuntu"
            host = aws_instance.denis_test_instance_terraform.public_ip
        }
    }
        tags = {
        Name = "Denis terraform instance"
        Owner = "Denis Subbota"
        Project = "terraform+k8s configuration"
    } 
}


# Generate inventory file 
resource "local_file" "inventory" {
 filename = "./Ansible/hosts"
 content = <<EOF
[all]
${aws_instance.denis_test_instance_terraform.public_ip}
# {aws_instance.webserver[1].public_ip}
# [dbserve]
# {aws_instance.dbserver[0].public_ip}
EOF
}

## Once Instance is ready let's run ansible playbook command over it
resource "null_resource" "ansiblePlaybook" {
  
 provisioner "local-exec" {
    command =  "ansible-playbook -i ./inventory/hosts k8s_primary.yaml"
  }
depends_on = [ aws_instance.denis_test_instance_terraform ]
}
 