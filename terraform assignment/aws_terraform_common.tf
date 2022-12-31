#terraform aws provider config
provider "aws"{
        region = "us-east-1"
        access_key= "AKIA4TLON2A73KMQNDWD"
        secret_key= "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"
}

#aws s3 bucket terraform state backup config
terraform {
        backend "s3"{
                bucket = "course11-assignment-bucket037"
                key = "terraform.tfstate"
                region = "us-east-1"
        }
}

#creating a key pair to access ec2 instances
resource "tls_private_key" "private_key"{
        algorithm = "RSA"
        rsa_bits = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ssh-key-pair-assignment"
  public_key = tls_private_key.private_key.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.private_key.private_key_pem}' >> ./ssh-key-pair-assignment.pem"
  }
}

resource "local_file" "private_key" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = "ssh-key-pair-assignment.pem"
  file_permission = "0600"
}
