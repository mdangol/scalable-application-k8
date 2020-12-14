
terraform {
    required_version = ">= 0.14.2"
}

resource "aws_cloudformation_stack" "demo-vpc" {
    name = "demo-vpc"
    parameters = {
        EnvironmentName="${var.EnvironmentName}"
        VpcCIDR="${var.VpcCIDR}"
        PublicSubnet1CIDR="${var.PublicSubnet1CIDR}"
        PublicSubnet2CIDR="${var.PublicSubnet2CIDR}"
        PrivateSubnet1CIDR="${var.PrivateSubnet1CIDR}"
        PrivateSubnet2CIDR="${var.PrivateSubnet2CIDR}"
    }
    template_body = "${
        file("../modules/vpc/vpc.yaml")
    }"
}