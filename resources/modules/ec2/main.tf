
terraform {
    required_version = ">= 0.14.2"
}

resource "aws_cloudformation_stack" "demo-ec2" {
    name = "demo-ec2"
    parameters = {
        InstanceName="demo-admin-instance"
        KeyName="${var.EC2KeyPairName}"
        ImageId="${var.EC2AdminImageId}"
        InstanceType="t2.micro"
        SecurityGroup="${var.securityGroupIds}"
        SubnetId="${var.SubnetId}"
    }
    template_body = "${
        file("../modules/ec2/ec2.yaml")
    }"

}

