provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  count         = length(var.config)
  instance_type = var.config[count.index].Tipo
  key_name      = "key-dufloth-devout"
  subnet_id     = var.config[count.index].SubnetId # vincula a subnet direto e gera o IP automático
  vpc_security_group_ids = [
    aws_security_group.allow_ssh_terraform.id,
  ]


  tags = {
    Name = "Dufloth-Maquina para testar VPC do terraform - ${var.config[count.index].Nome}"
  }
  root_block_device {
    encrypted = true
    #kms_key_id  = "arn:aws:kms:us-east-1:534566538491:key/90847cc8-47e8-4a75-8a69-2dae39f0cc0d"
    volume_size = 20
  }



}
