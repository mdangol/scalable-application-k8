variable "EnvironmentName" {
    type = string
    description = "EnvironmentName"
}

variable "VpcCIDR" {
    type = string
    description = "VpcCIDR"
}

variable "PublicSubnet1CIDR" {
    type = string
    description = "PublicSubnet1CIDR"
}

variable "PublicSubnet2CIDR" {
    type = string
    description = "PublicSubnet2CIDR"
}

variable "PrivateSubnet1CIDR" {
    type = string
    description = "PrivateSubnet1CIDR"
}

variable "PrivateSubnet2CIDR" {
    type = string
    description = "PrivateSubnet2CIDR"
}

variable "EC2KeyPairName" {
    type = string
    description = "EC2KeyPairName"
}

variable "EC2AdminImageId" {
    type = string
    description = "EC2AdminImageId"
}

variable "WorkerNodesImageId" {
    type = string
    description = "WorkerNodesImageId"
}


