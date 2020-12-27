terraform {
  backend "remote" {
    organization = var.org
    workspaces {
      name = "glg-staging"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "paulmc"
  region  = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0ce1e3f77cd41957e"
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}

output "ip" {
  value = aws_eip.ip.public_ip
}
