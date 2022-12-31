#getting the self ip of a machine to configure it in the security group
data "http" "myip"{
        url = "http://ipv4.icanhazip.com"
}

#creating security groups for bastion host
resource "aws_security_group" "bastion_host_sg"{
        name = "bastion-host-sg"
        description = "SSH to Bastion host"
        vpc_id = aws_vpc.assignment-vpc.id
        ingress{
                description = "SSH to Bastion Host"
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
        }

        egress{
                from_port = 0
                to_port = 0
                protocol = "all"
                cidr_blocks = ["0.0.0.0/0"]
        }
}


#creating security group for private instance
resource "aws_security_group" "private_instance_sg"{
        name = "private-instance-sg"
        description = "All incoming and outgoing traffic allowed"
        vpc_id = aws_vpc.assignment-vpc.id
        ingress{
                description = "Allowing all incoming traffic"
                from_port = 0
                to_port = 0
                protocol = "all"
                cidr_blocks = ["10.0.0.0/16"]
        }

        egress{
                from_port = 0
                to_port = 0
                protocol = "all"
                cidr_blocks = ["0.0.0.0/0"]
        }
}

#creating security group for public web instance
resource "aws_security_group" "public_web_instance_sg"{
        name = "public-instance-sg"
        description = "All incoming to port 80 from self ip and all egress"
        vpc_id = aws_vpc.assignment-vpc.id
        ingress{
                description = "Allowing all incoming traffic to port 80"
                from_port = 0
                to_port = 65535
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        egress{
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
}
