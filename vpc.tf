resource "aws_vpc" "denis_k8s_vpc" {
  cidr_block = "10.0.0.0/18"

  tags = {
    Name = "denis_k8s_vps VPC"
  } 

}
resource "aws_subnet" "public_subnet_denis" {
  vpc_id = aws_instance.denis_test_instance_terraform.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1d"
  
  tags ={
    Name= "Public Subnet Denis"
  } 
}
resource "aws_subnet" "private_subnet_denis" {
  vpc_id = aws_instance.denis_test_instance_terraform.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1d"
  
  tags ={
    Name= "Private Subnet Denis"
  } 
}

resource "aws_internet_gateway" "internet_gateway_denis" {
  vpc_id = aws_vpc.denis_k8s_vpc.id

  tags = {
    Name = "Denis_VPC internet gateway"
  }
}
resource "aws_route_table" "public_rt_denis" {
    vpc_id = aws_vpc.denis_k8s_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway_denis.id
    }
     tags ={
    Name= "Public Route Table Denis"
     }
  } 

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public_subnet_denis.id
    route_table_id = aws_route_table.public_rt_denis.id
  
}

  
