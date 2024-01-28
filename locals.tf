locals {
  env = {
    default = {
      instance_name = "${terraform.workspace}-vm01"
      instance_type = "t3.small"
      environment   = "default"
    }
    dev = {
      instance_name = "${terraform.workspace}-vm01"
      instance_type = "t3.small"
      environment   = "dev"
    }
    uat = {
      instance_name = "${terraform.workspace}-vm01"
      instance_type = "t3.medium"
      environment   = "uat"
    }
    prd = {
      instance_name = "${terraform.workspace}-vm01"
      instance_type = "t3.large"
      environment   = "prd"
    }
  }
}
 