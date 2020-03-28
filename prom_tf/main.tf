resource "aws_instance" "my-test-instance" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_aws_key.key_name

  security_groups = [
    aws_security_group.allow_ssh.name,
    aws_security_group.allow_outbound.name,
    aws_security_group.allow_prom.name,
    aws_security_group.allow_grafana.name,
    aws_security_group.allow_alert.name,
    aws_security_group.allow_custom.name,
    aws_security_group.allow_nginx.name,
    aws_security_group.allow_nrpe.name
  ]

  tags = {
    Name = "prometheus-demo"
  }

  provisioner "remote-exec" {
    inline = ["sudo yum -y install python"]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.ssh_private_key)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ${var.ssh_private_key} docker.yml"
  }
}

