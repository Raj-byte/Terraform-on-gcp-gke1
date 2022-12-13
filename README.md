# Terraform-on-gcp-gke1
###it is for practicse
Getting Started:-  

Install Terraform cli from the official site of terraform .

Install cloud sdk on your terminal to you google cloud using command line or bash terminal.

You will need a file with the credentials that Terraform needs to interact with the Google Cloud API to create the cluster and related networking components.

Go to Google cloud console and login with your id.

After that Go to IAM&Admin section –> service account –>Create a service account–>in service account permission –>project:owner from dropdown menu
On next page click on CREATE KEY and select Json key type. 

Now the keys json file will be downloaded .

After download finishes . create a directory where you will store your terraform file and execute it.

Next, create a file named  provider.tf, and add these lines of code:
provider "google" {
  credentials = file("./.json")
  project     = ""
  region      = "us-central1"
  version     = "~> 2.5.0"
}

Fill in the the project name with the ID of the project you created in the GCP Console
E.g :- project id :-terraform-ongcp-34567

Fill in the credentials filename with the name of the service account key file that you just downloaded and moved to the project folder. 
e.g)Downloaded file is:- terraform-ongcp-34567.json
Now renamed file can be :- cerenditals.json

Now start to create the terraform tf files to provision your infrastructure
e.g)>>> .
├── 2-vpc.tf
├── 3-subnets.tf
├── 4-router.tf
├── 5-nat.tf
├── 6-firewalls.tf
├── 7-kubernetes.tf
├── 8-node-pools.tf
├── cerenditals.json
├── providers.tf
├── provider.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraformvar.tfvars
└── variable.tf

After creating configure Google cloud sdk .
-gcloud init
    :- select your project and confirm your emailid when prompted. 

After that install kubectl 

Then execute your terraform file By:

Terraform init :-where it will download the provider plugins required to provision your infrastructure

Terraform plan :- where the blueprint of your infrastructure will be made

Terraform apply :- where you finally deploy and provision your infrastructure on the provider you provide .

