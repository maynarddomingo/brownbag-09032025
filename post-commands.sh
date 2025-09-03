#post commands.

#Step 1: Build the Docker image
docker build -t devops-toolbox-debian-bwslime .

#Step 2: Run the container with AWS credentials and workspace mounted
  docker run -it --rm \
    -v $HOME/.aws:/root/.aws \
    -v /Users/maynarddomingo/docker/brownbag0803:/workspace \
    devops-toolbox-debian-bwslim:latest bash

 # Run AWS CLI command to verify credentials
   aws sts get-caller-identity

#Step 3: Attach the service user inline policies necessary to manage the EKS and other resources.
#Step 4: Create the EKS roles

#Step 5: Create the EKS cluster
  aws eks create-cluster \
    --name my-eks-cluster \
    --role-arn arn:aws:iam::<ACCOUNT_ID>:role/EKS-ClusterRole \
    --resources-vpc-config subnetIds=subnet-04e617b19b9483fd1,subnet-0c9123ec4b0cf09b2,securityGroupIds=sg-05f661f56c8605e2b \
    --region us-east-1

#Step 6: Verify the EKS cluster status
aws eks describe-cluster \
  --name my-eks-cluster \
  --query "cluster.status" \
  --region us-east-1

#Step 7: Update the kubeconfig file to use the new EKS cluster
aws eks update-kubeconfig --name  my-eks-cluster --region us-east-1
kubectl get nodes


#Step 8: Create the EKS node group

aws eks create-nodegroup \
  --cluster-name my-eks-cluster \
  --nodegroup-name my-eks-nodegroup \
  --subnets subnet-04e617b19b9483fd1 subnet-0c9123ec4b0cf09b2 \
  --node-role arn:aws:iam::arn:aws:iam::420859418419:role/EKS-NodeRole \
  --scaling-config minSize=1,maxSize=2,desiredSize=1 \
  --instance-types t3.small \
  --region us-east-1


  aws eks describe-cluster \
  --name my-eks-cluster \
  --query "cluster.version" \
  --region us-east-1

  aws eks describe-nodegroup \
  --cluster-name my-eks-cluster \
  --nodegroup-name my-eks-nodegroup \
  --region us-east-1 \
  --query 'nodegroup.status'

  aws eks describe-nodegroup \
  --cluster-name my-eks-cluster \
  --nodegroup-name my-eks-nodegroup \
  --region us-east-1


kubectl get nodes
kubectl get nodes --show-labels
kubectl get svc
kubectl get 

#Step 9: Deploy sample application to the EKS cluster
kubectl apply -f service.yaml
kubectl get pods
kubectl get pods -l app=my-website
kubectl delete deployment my-website


#Step 10 : Access the sample application
kubectl apply -f service.yaml
kubectl get svc my-website-svc
kubectl get svc
kubectl logs my-website-69bd8cc75-7q55q
kubectl delete service my-website-svc


#Step 11 : Scallability part
kubectl scale deployment nginx-website --replicas=3
kubectl scale deployment my-website --replicas=2
 
#Step 12 : Clean up resources
aws eks delete-nodegroup \
  --cluster-name my-eks-cluster \
  --nodegroup-name my-eks-nodegroup \
  --region us-east-1

  aws eks delete-cluster \
  --name my-eks-cluster \
  --region us-east-1