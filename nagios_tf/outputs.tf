output "address" {
  value = "Instances: ${join("|", aws_instance.nagios.*.id)}"
}

output "ip" {
    value = "Public IP: ${join("|", aws_instance.nagios.*.public_ip)}"
}