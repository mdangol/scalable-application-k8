provider "aws" {
  region = "us-east-1"
}

module "vpc_setup" {
    source = "../modules/vpc"
    EnvironmentName="${var.EnvironmentName}"
    VpcCIDR="${var.VpcCIDR}"
    PublicSubnet1CIDR="${var.PublicSubnet1CIDR}"
    PublicSubnet2CIDR="${var.PublicSubnet2CIDR}"
    PrivateSubnet1CIDR="${var.PrivateSubnet1CIDR}"
    PrivateSubnet2CIDR="${var.PrivateSubnet2CIDR}"

}

data "aws_cloudformation_export" "demo-vpc-ec2" { 
    name = "demo-vpc-VPCID"
}

data "aws_cloudformation_export" "demo-sg-ec2" { 
    name = "demo-vpc-SG"
}

data "aws_subnet_ids" "all_subnet_ids-ec2" {
    vpc_id = data.aws_cloudformation_export.demo-vpc-ec2.value
}

data "aws_subnet" "all_subnets-ec2" {
    for_each = data.aws_subnet_ids.all_subnet_ids-ec2.ids
    id = each.value
}

data "aws_cloudformation_export" "demo-eks-iam-role" {
    name = "demo-eks-iam-role-RoleArn"
}

output "subnets_two_private" {
  value = join(", ", [for i in data.aws_subnet.all_subnets-ec2: i.id if i.tags.Name=="${var.EnvironmentName} Private Subnet (AZ2)" || i.tags.Name=="${var.EnvironmentName} Private Subnet (AZ1)"])

}

output "subnetsall" {
    value = [for i in data.aws_subnet.all_subnets-ec2: i.id if i.tags.Name=="${var.EnvironmentName} Private Subnet (AZ2)"]
}

output "ENVNAME" {
    value = "${var.EnvironmentName} Private Subnet (AZ2)"
}

module "ec2-admin-setup" {
    source = "../modules/ec2"
    EC2KeyPairName="${var.EC2KeyPairName}"
    EC2AdminImageId="${var.EC2AdminImageId}"
    securityGroupIds=data.aws_cloudformation_export.demo-sg-ec2.value
    SubnetId=join(", ", [for i in data.aws_subnet.all_subnets-ec2: i.id if i.tags.Name=="${var.EnvironmentName} Public Subnet (AZ2)"])
    depends_on = [module.vpc_setup]    
}


module "eks-iam-role" {
    source = "../modules/eks-iam"
}

module "eks" {
  source = "../modules/eks"
  EKSRole = data.aws_cloudformation_export.demo-eks-iam-role.value
  SubnetIds=join(", ", data.aws_subnet_ids.all_subnet_ids-ec2.ids)
  SecurityGroupIds=data.aws_cloudformation_export.demo-sg-ec2.value
  PrivateSubnets=join(", ", [for i in data.aws_subnet.all_subnets-ec2: i.id if i.tags.Name=="${var.EnvironmentName} Public Subnet (AZ2)" || i.tags.Name=="${var.EnvironmentName} Public Subnet (AZ1)"])
  WorkerNodesImageId="${var.WorkerNodesImageId}"
  EC2KeyPairName="${var.EC2KeyPairName}"
  depends_on = [module.vpc_setup, module.eks-iam-role]
}

