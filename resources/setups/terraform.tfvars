
profile = "demo-admin"

##########################################

EC2KeyPairName = "ec2-demo"

EC2AdminImageId = "ami-04d29b6f966df1537"

##### VPC Vars ###########################

EnvironmentName="sbx"
VpcCIDR="10.0.0.0/16"
PublicSubnet1CIDR="10.0.0.0/24"
PublicSubnet2CIDR="10.0.1.0/24"
PrivateSubnet1CIDR="10.0.2.0/24"
PrivateSubnet2CIDR="10.0.3.0/24"

##### EKS ##########

WorkerNodesImageId = "ami-0f4cae6ae56be18ee"
