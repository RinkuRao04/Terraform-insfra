backend "s3" {
    bucket         	   = "mycomponents-tfstate-01"
    key                = "state/terraform.tfstate"
    region         	   = "eu-central-1"
   
  }