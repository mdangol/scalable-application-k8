terraform {
    required_version = ">= 0.14.2"
}


resource "aws_cloudformation_stack" "demo-eks-iam-role" {
    name = "demo-eks-iam-role"
   
    template_body = "${
        file("../modules/eks-iam/eks-iam.yaml")
    }"

    capabilities = ["CAPABILITY_IAM"]
}