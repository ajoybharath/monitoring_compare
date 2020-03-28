variable "aws_access_key" {
  default = "<YOUR ACCESS KEY>"
}

variable "aws_secret_key" {
  default = "<YOUR SECRET KEY>"
}

variable "aws_region" {
  default = "us-east-2"
}

# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    "eu-west-1" = "ami-01793b684af7a3e2c"
    "us-east-1" = "ami-04ac550b78324f651"
    "us-west-1" = "ami-0798ac7e2b0fb9e75"
    "us-east-2" = "ami-046cfe1f8332fd5f2"
  }
}

variable "ssh_private_key" {
  description = "File location of the ssh private key"
  default     = "/home/akbharath/.ssh/id_rsa"
}