terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60.0"
    }
  }
  backend "s3" {
    bucket         	   = "mycomponents-tfstate-01"
    key                = "state/terraform.tfstate"
    region         	   = "var.region"
   
  }
}

#Connect with aws account using secret_key and access_id 
provider "aws" {
  region     = var.region

}

# Genrate Aws key pair 
# resource "tls_private_key" "example" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "genrate_key" {
#   key_name   = "test"
#   public_key = tls_private_key.example.public_key_openssh
#    provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
#     command = "echo '${tls_private_key.example.private_key_pem}' > ./test.pem"
#   }
# }

# # output collect key 
# output "private_key" {
#   value     = tls_private_key.example.private_key_pem
#   sensitive = true
# }
