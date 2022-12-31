#ubuntu ami selection
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

#bastion EC2 instance creation
resource "aws_instance" "bastion_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]
  subnet_id              = aws_subnet.public-subnet1.id
  tags = {
    Name = "Bastion Instance"
  }
}

#Jenkins EC2 instance creation
resource "aws_instance" "jenkins_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
  subnet_id              = aws_subnet.private-subnet1.id
  tags = {
    Name = "Jenkins Instance"
  }
}

#App server EC2 instance creation
resource "aws_instance" "app_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
  subnet_id              = aws_subnet.private-subnet1.id
  tags = {
    Name = "App Instance"
  }
}

#public ip linking to bastion instance
resource "aws_eip" "bastion_instance_eip" {
  instance = "${aws_instance.bastion_instance.id}"
  vpc      = true
}


