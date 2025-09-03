 
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = "arn:aws:iam::420859418419:role/EKS-ClusterRole"

  vpc_config {
    subnet_ids = [
      "subnet-04e617b19b9483fd1",
      "subnet-0c9123ec4b0cf09b2"
    ]
    security_group_ids = ["sg-05f661f56c8605e2b"]
  }

  # Optional: Kubernetes version (matches default for CLI)
  # version = "1.32"

  tags = {
    Name = "my-eks-cluster"
  }
}

resource "aws_eks_node_group" "my_nodes" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-eks-nodegroup"
  node_role_arn   = "arn:aws:iam::420859418419:role/EKS-NodeRole"
  subnet_ids = [
    "subnet-04e617b19b9483fd1",
    "subnet-0c9123ec4b0cf09b2"
  ]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  instance_types = ["t3.small"]

  # Optional tags
  tags = {
    Name = "my-eks-nodegroup"
  }
}