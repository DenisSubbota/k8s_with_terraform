provider "aws" {
    profile = "AdministratorAccess-562648626458"
}

resource "aws_instance" "denis_test_instance_terraform" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.private_subnet_denis.id
    vpc_security_group_ids = [aws_security_group.k8s_security_group.id]
        
        tags = {
        Name = "Denis terraform instance"
        Owner = "Denis Subbota"
        Project = "terraform+k8s configuration"
    } 
}

