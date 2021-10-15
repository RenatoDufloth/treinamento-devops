provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "key-dufloth-devout" # key chave publica cadastrada na AWS 
  # subnet_id        =  aws_subnet.my_subnet.id # vincula a subnet direto e gera o IP automático
  tags = {
    Name = "Dufloth-Maquina para testar Ansible"
  }
  subnet_id                   = "subnet-05cdfe4fe6a3d1c13"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh.id}","${aws_security_group.allow_80.id}" ]
  root_block_device {
    encrypted = true
    #kms_key_id  = "arn:aws:kms:us-east-1:534566538491:key/90847cc8-47e8-4a75-8a69-2dae39f0cc0d"
    volume_size = 20
  }
}
