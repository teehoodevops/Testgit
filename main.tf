

data "aws_key_pair" "Teehookeypair" {
  key_name           = "Teehookeypair"
  include_public_key = true



}
resource "aws_instance" "teehoo" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "Teehookeypair"
  vpc_security_group_ids = [aws_security_group.SG.id]


  tags = {
    Name = "webserver"
  }

}
resource "aws_security_group" "SG" {

  name = "terraform-webserverSG"


  ingress {
    description = "Allow SSH"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }







  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}



output "instance_ip_addr" {
  value       = aws_instance.teehoo.private_ip
  description = "The private IP address of the main server instance."
}


