output "instance_public_ip" {
    value = aws_instance.example.public_ip
}

# Use this output to retrieve the public IP address 
# of the EC2 instance after 
# applying the Terraform configuration.

# instance_public_ip is the name we chose

# aws_instance.example <= refers to resource block in main.tf
