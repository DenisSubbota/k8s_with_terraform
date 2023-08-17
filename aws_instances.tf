# Create a public key on the AWS 
resource "aws_key_pair" "denis_pub_key" {
	key_name = "denis_pub_key"
	public_key = "${file("denis_ssh_key.pub")}"
}

#Creating single ec2 instance - control plane 
resource "aws_instance" "kuber_control_plane_denis" {
    ami = var.ami-centos
    instance_type = var.instance-type
    subnet_id = aws_subnet.public_subnet_denis.id #were needed for vpc.tf and nat.tf 
    vpc_security_group_ids = [ aws_security_group.k8s_security_group.id ]
    key_name = "denis_pub_key"
## IMPORTANT: All Provisioners are running only over freshly created instances, and if you updated provisioner you need to destroy and create env again.
## Work-around to verify that instance accessable through ssh  
    provisioner "remote-exec" {
        inline = ["echo 'Wait untill SSH is ready' "]
        connection{
            type = "ssh"
            user = "centos"
            host = aws_instance.kuber_control_plane_denis.public_ip
        }
    }
        tags = {
        Name = "Denis terraform instance"
        Owner = "Denis Subbota"
        Project = "terraform+k8s configuration"
        PerconaCreatedBy = "denis.subbota@percona.com"
        Role = "Control Plane"
    } 
}

#Creating ec2 instance - worker nodes
resource "aws_instance" "kuber_worker_node_denis" {
    count = 2 
    ami = var.ami-centos 
    instance_type = var.instance-type
    subnet_id = aws_subnet.public_subnet_denis.id #were needed for vpc.tf and nat.tf 
    vpc_security_group_ids = [ aws_security_group.k8s_security_group.id ]
    key_name = "denis_pub_key"
## IMPORTANT: All Provisioners are running only over freshly created instances, and if you updated provisioner you need to destroy and create env again.
## Work-around to verify that instance accessable through ssh  
    provisioner "remote-exec" {
        inline = ["echo 'Wait untill SSH is ready' "]
        connection{
            type = "ssh"
            user = "centos"
            host = self.public_ip
        }
    }
        tags = {
        Name = "Denis terraform instance"
        Owner = "Denis Subbota"
        Project = "terraform+k8s configuration"
        PerconaCreatedBy = "denis.subbota@percona.com"
        Role = "K8s worker node "
    } 
}
