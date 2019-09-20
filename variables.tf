variable "aws_region" {
  description = "AWS region on which we will setup the swarm cluster"
  default     = "us-east-1"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default     = "ami-4fffc834"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH Public Key path"
  default     = "./project_agtlk.pem"
}

variable "avail_zones" {
  type = "map"

  default = {
    "us-east-1" = [
      "us-east-1a",
      "us-east-1b",
      "us-east-1c",
      "us-east-1d",
      "us-east-1e",
      "us-east-1f",
    ]
  }
}
