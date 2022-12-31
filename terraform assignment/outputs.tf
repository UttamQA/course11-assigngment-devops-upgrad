output "aws_vpc_output"{
        value = aws_vpc.assignment-vpc.arn
        description = "The ARN of the assignment vpc"
}

output "aws_public_subnet1_output"{
        value = aws_subnet.public-subnet1.arn
        description = "The ARN of the public subnet1"
}

output "aws_public_subnet2_output"{
        value = aws_subnet.public-subnet2.arn
        description = "The ARN of the public subnet2"
}

output "aws_private_subnet1_output"{
        value = aws_subnet.private-subnet1.arn
        description = "The ARN of the private subnet1"
}

output "aws_private_subnet2_output"{
        value = aws_subnet.private-subnet2.arn
        description = "The ARN of the private subnet2"
}

output "aws_internet_gateway_output"{
        value = aws_internet_gateway.IGW.arn
        description = "The ARN of the internet gateway"
}

output "aws_nat_gateway_output"{
        value = aws_nat_gateway.NGW.public_ip
        description = "The ARN of the NAT gateway"
}

output "aws_route_table_public_subnet_output"{
        value = aws_route_table.public_subnet_rt.arn
        description = "The ARN of the route table of public subnet"
}

output "aws_route_table_nat_gateway_output"{
        value = aws_route_table.ngw_rt.arn
        description = "The ARN of the route table of nat gateway"
}

output "response_body" {
  value = data.http.myip.response_body
}
