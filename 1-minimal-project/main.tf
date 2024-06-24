provider "aws" {
    region = var.region
}

resource "aws_instance" "example" {
    ami           = var.ami_id
    instance_type = var.instance_type
    associate_public_ip_address = true
    vpc_security_group_ids = ["sg-03ebfed1807cbb489"]
    subnet_id = "subnet-02d876e2f58435170"
    tags = {
        Name = "example_instance"
    }
}
