provider "aws" {
  region = "us-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

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


resource "aws_instance" "jenkins" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.large"
  key_name                    = "key-dufloth-devout"
  subnet_id                   = "subnet-05cdfe4fe6a3d1c13"
  associate_public_ip_address = true
  root_block_device {
    encrypted   = true
    volume_size = 20
  }
  tags = {
    Name = "dufloth-jenkins"
  }
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
}

resource "aws_security_group" "jenkins" {
  name        = "acessos_jenkins"
  description = "acessos_jenkins inbound traffic"
  vpc_id      = "vpc-0404e2502328d5e45"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "SSH from VPC"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
      description : "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "dufloth-jenkins-lab"
  }
}

# terraform refresh para mostrar o ssh
output "jenkins" {
  value = [
    "jenkins",
    "id: ${aws_instance.jenkins.id}",
    "private: ${aws_instance.jenkins.private_ip}",
    "public: ${aws_instance.jenkins.public_ip}",
    "public_dns: ${aws_instance.jenkins.public_dns}",
    "ssh -i ~/Desktop/devops/treinamentoItau ubuntu@${aws_instance.jenkins.public_dns}"
  ]
}
