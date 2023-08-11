# #Elastic IP for NAT Gateway
# resource "aws_eip" "nat_eip_denis" {
# #  vpc = true
#   domain = "vpc"
#   depends_on = [ aws_internet_gateway.internet_gateway_denis ]
#   tags = {
#     Name ="NAT gatewey EIP Denis"
#   }
# }

# resource "aws_nat_gateway" "nat_denis" {
#   allocation_id =  aws_eip.nat_eip_denis.id
#   subnet_id =  aws_subnet.public_subnet_denis.id
#   tags ={
#     Name = "Denis_vpc NAT gateway"
#   }  
# }

# resource "aws_route_table" "private_route_denis" {
#     vpc_id = aws_vpc.denis_k8s_vpc.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_nat_gateway.nat_denis.id
#     }

#     tags = {
#       Name = "Private Route Table Denis"
#     }
# }

# resource "aws_route_table_association" "private" {
#   subnet_id = aws_subnet.private_subnet_denis.id
#   route_table_id = aws_route_table.private_route_denis.id
# }
