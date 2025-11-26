EKS + Terraform setup instructions for **Linux EC2** and **Mac (Brew)** environments.

---

##  Terraform EKS Cluster Setup — Full Sequence

---

###  1️⃣ Clone and Prepare Terraform EKS Project

```bash
git clone https://github.com/dhruvj11/terraform-eks-nginx.git
cd terraform-eks-cluster
terraform init
terraform plan
terraform apply
```

---

###  2️⃣ Install AWS CLI & kubectl

####  On **Linux (EC2 / Cloud Shell)**

```bash
sudo yum install -y aws-cli
curl -o kubectl https://s3.us-east-1.amazonaws.com/amazon-eks/1.29.1/2024-04-09/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/
```

####  On **Mac (Brew)**

```bash
brew install awscli
brew install kubectl
# OR if already installed
brew reinstall kubernetes-cli
```

---

###  3️⃣ Configure kubeconfig for EKS Cluster Access

#### **Without Profile**

```bash
aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
```

#### **With AWS Profile (Optional)**

```bash
aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster --profile default
```

---

###  4️⃣ Verify kubectl Config & Context

```bash
kubectl config get-contexts
kubectl config use-context arn:aws:eks:us-east-1:<account-id>:cluster/my-eks-cluster
```

---

###  5️⃣ Check EKS Cluster Status

```bash
kubectl get nodes
kubectl cluster-info
```

---

###  6️⃣ Review Terraform Outputs

```bash
terraform output
terraform output cluster_name
terraform output cluster_endpoint
terraform output kubeconfig_certificate_authority_data
```

---

###  7️⃣ Validate AWS Identity

```bash
aws sts get-caller-identity
```

---

###  8️⃣ Apply EKS RBAC Configuration (Optional)

If you have a `eks-master-admin-binding.yaml`:

```bash
kubectl apply -f eks-master-admin-binding.yaml
```

Check current config:

```bash
kubectl get configmap aws-auth -n kube-system -o yaml
```

---

###  9️⃣ IAM Access Entry (in AWS Console)

Go to:
**Amazon EKS Console → Clusters → my-eks-cluster → IAM access entries**

**Add User:**

* **username**: `dhruv`
* **group name**: `eks-master`
* **Access Policies**:

  * `AmazonEKSAdminPolicy`
  * `AmazonEKSViewPolicy`

---

### 📌 🔟 Destroy EKS Cluster (When Done)

```bash
terraform destroy
```

---

✅ That’s a clean, properly sequenced, and categorized workflow for setting up and managing an EKS cluster via Terraform and kubectl both on Linux and Mac.
