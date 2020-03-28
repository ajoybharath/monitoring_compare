# Specify the provider and access details
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region

  version = "~> 2.0"
}

#resource "aws_elb" "web" {
#  name = "terraform-example-elb"

  # The same availability zone as our instances
#  availability_zones = aws_instance.web.*.availability_zone

#  listener {
#    instance_port     = 80
#    instance_protocol = "http"
#    lb_port           = 80
#    lb_protocol       = "http"
#  }

  # The instances are registered automatically
#  instances = aws_instance.web.*.id
#}

resource "aws_instance" "nagios" {
  instance_type = "t2.micro"
  ami           = var.aws_amis[var.aws_region]
  key_name      = aws_key_pair.my_aws_key.key_name

  security_groups = [
    aws_security_group.allow_ssh.name,
    aws_security_group.allow_outbound.name,
    aws_security_group.allow_http.name 
  ]

  provisioner "remote-exec" {
    inline = ["sudo apt-get update && sudo apt-get install python -y"]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.ssh_private_key)
    host        = self.public_ip
    }
  }
  # This will create 4 instances
  count = 2
}