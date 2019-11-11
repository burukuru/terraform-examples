provider "aws" {
  region = "eu-west-1"
}

variable "amis" {
  type = "map"
  default = {
    "amazon" = "amzn2-ami-hvm-2.0.20191024.3-x86_64-gp2"                         # ami-040ba9174949f6de4
    "ubuntu" = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20191002" # ami-02df9ea15c1778c9c
  }
}

data "aws_ami" "this" {
  for_each = var.amis

  owners      = ["amazon", "099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = [each.value]
  }
}

resource "aws_instance" "ec2" {
  for_each = data.aws_ami.this

  instance_type = "t3.micro"
  ami           = each.value.image_id

  tags = {
    "Name" = each.key
  }
}
