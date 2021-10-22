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

resource "aws_instance" "jenkins-lab" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.medium"
  key_name      = "key-dufloth-devout"
  subnet_id                   = "subnet-05cdfe4fe6a3d1c13"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    #kms_key_id  = "arn:aws:kms:us-east-1:534566538491:key/90847cc8-47e8-4a75-8a69-2dae39f0cc0d"
    volume_size = 20
  }
  tags = {
    Name = "dufloth-jenkins-lab"
  }
  vpc_security_group_ids = ["${aws_security_group.acessos.id}"]
}



resource "aws_security_group" "acessos" {
  name        = "jenkins-acessos"
  description = "acessos inbound traffic"
  vpc_id      = "vpc-0404e2502328d5e45"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      description      = "Libera 80"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    }
    ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "dufloth-Jenkinss-allow_ssh"
  }
}




output "output-jenkins_lab" {
  value = [
    "k8s_proxy - ${aws_instance.jenkins-lab.private_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.k8s_proxy.public_dns}"
  ]
}
  
# terraform refresh para mostrar o ssh
