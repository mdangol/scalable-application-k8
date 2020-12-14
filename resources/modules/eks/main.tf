terraform {
    required_version = ">= 0.14.2"
}

resource "aws_cloudformation_stack" "demo-eks" {
    name = "demo-eks"

    parameters = {
        EKSClusterName="demo-admin-instance"
        EKSRole="${var.EKSRole}"
        SubnetIds="${var.SubnetIds}"
        SecurityGroupIds="${var.SecurityGroupIds}"
        PrivateSubnets="${var.PrivateSubnets}"
        WorkerNodesImageId="${var.WorkerNodesImageId}"
        KeyPairName="${var.EC2KeyPairName}"
    
    }
    template_body = "${
        file("../modules/eks/eks.yaml")
    }"

    capabilities = ["CAPABILITY_IAM"]

   }

