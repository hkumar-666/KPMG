terraform {
backend "s3" {

   region = "ap-south-1"
   bucket = "india-terraform-remote-state"
   dynamodb_table = "dynamo-india-terraform-remote-state"
   key = "ap-south-1/state.tfstate"
   encrypt = true
   }
}
