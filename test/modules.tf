module "vpc" {
  source = "./vpc"
  vpc_cidr = "${var.vpc_cidr}"
  project_name = "${var.project_name}"
  project_env = "${var.project_env}"
  
}