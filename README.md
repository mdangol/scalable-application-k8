# immutable-deployment-demo

1. Building Infrastructure
    i. VPC  
        terraform init
        terraform apply -target=module.vpc_setup

    ii. EKS IAM Role
        terraform apply -target=module.eks-iam-role

    iii. Admin EC2 Instance and EKS
        terraform apply

2. Deploying Jenkins into EKS cluster

3. Create a sample application

4. Create Jenkins pipeline to deploy sample application into EKS