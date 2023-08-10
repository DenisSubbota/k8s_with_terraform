provider "aws" {
    
}

resource "aws_security_group" "k8s_security_group" {
    name = "Dinamic Security group"

    dynimic "ingress" {
        for each ["80","443"]
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
}