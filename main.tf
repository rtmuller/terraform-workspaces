resource "aws_instance" "example" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = local.env[terraform.workspace].instance_type

  tags = {
    Name        = local.env[terraform.workspace].instance_name
    Environment = local.env[terraform.workspace].environment
    Terraform   = true
  }
}