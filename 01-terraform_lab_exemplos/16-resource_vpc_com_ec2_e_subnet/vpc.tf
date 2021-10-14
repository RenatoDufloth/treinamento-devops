resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "dufloth-tf-lab-danilo-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "dufloth-tf-lab-danilo-subnet"
  }
}

resource "aws_subnet" "my_subnet_b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.20.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "dufoth-tf-lab-danilo-subnet_b"
  }
}

resource "aws_subnet" "my_subnet_c" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.30.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "dufloth-tf-lab-danilo-subnet_c"
  }
}


resource "aws_network_interface" "my_subnet" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.101"] # IP definido para instancia
  # security_groups = ["${aws_security_group.allow_ssh1.id}"]

  tags = {
    Name = "dufloth-primary_network_interface my_subnet"
  }
}


resource "aws_network_interface" "my_subnet_b" {
  subnet_id   = aws_subnet.my_subnet_b.id
  private_ips = ["172.16.20.100"] # IP definido para instancia
  # security_groups = ["${aws_security_group.allow_ssh1.id}"]

  tags = {
    Name = "dufloth-primary_network_interface my_subnet_b"
  }
}
