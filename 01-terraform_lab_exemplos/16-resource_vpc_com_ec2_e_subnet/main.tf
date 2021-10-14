provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "key-dufloth-devout" # key chave publica cadastrada na AWS 
  # subnet_id        =  aws_subnet.my_subnet.id # vincula a subnet direto e gera o IP automático
  tags = {
    Name = "Dufloth-Maquina para testar VPC"
  }

  network_interface {
    network_interface_id = aws_network_interface.my_subnet.id # vincula a subnet com ip fixo
    device_index         = 0                                  # DeviceIndex - The network interface's position in the attachment order. For example, the first attached network interface has a DeviceIndex of 0. 

  }
  root_block_device {
    encrypted = true
    #kms_key_id  = "arn:aws:kms:us-east-1:534566538491:key/90847cc8-47e8-4a75-8a69-2dae39f0cc0d"
    volume_size = 20
  }

}


resource "aws_instance" "web2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "key-dufloth-devout"
  tags = {
    Name = "Dufloth-Maquina2 para testar VPC"
  }

  network_interface {
    network_interface_id = aws_network_interface.my_subnet_b.id # vincula a subnet com ip fixo
    device_index         = 0
  }
  root_block_device {
    encrypted = true
    #kms_key_id  = "arn:aws:kms:us-east-1:534566538491:key/90847cc8-47e8-4a75-8a69-2dae39f0cc0d"
    volume_size = 20
  }

}


resource "aws_instance" "web3" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = "key-dufloth-devout"
  root_block_device {
    encrypted = true
    #kms_key_id  = "arn:aws:kms:us-east-1:534566538491:key/90847cc8-47e8-4a75-8a69-2dae39f0cc0d"
    volume_size = 20
  }

  tags = {
    Name = "Dufloth-Maquina3 para testar VPC"
  }
  subnet_id = aws_subnet.my_subnet_c.id
}
