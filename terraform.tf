provider "aws" {
    profile = "sso-aws-gs-sandbox-engineer-482433642182"
}

resource "aws_instance" "denis_test_instance_terraform" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.k8s_security_group.id]
        
        tags = {
        Name = "Denis terraform instance"
        Owner = "Denis Subbota"
        Project = "terraform+k8s configuration"
    } 
  
}

resource "aws_security_group" "k8s_security_group" {
    name = "Dinamic Security group"

    dynamic "ingress" {
        for_each = [ "22","6443" ]
        content {
            from_port = ingress.value
            to_port   = ingress.value
            protocol  = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Denis terraform security group"
        Owner = "Denis Subbota"
        Project = "terraform+k8s configuration"
    } 

}