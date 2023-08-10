resource "aws_security_group" "k8s_security_group" {
    name = "Dynamic Security group"
    vpc_id = aws_vpc.denis_k8s_vpc.id
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