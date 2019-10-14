module "vpc" {
  source = "./vpc"
  vpc_cidr = "${var.vpc_cidr}"
  project_name = "${var.project_name}"
  project_env = "${var.project_env}"
  
}

#module "ec2" {
 # source = "./ec2"
#  subnets_id = "${module.vpc.subnets_id}"
 # vpc_id = "${module.vpc.vpc_id}"
  #project_name = "${var.project_name}"
  #project_env = "${var.project_env}"
  
#}

module "rds" {
  source = "./rds"
  subnets_id = "${module.vpc.subnets_id}"
  vpc_id = "${module.vpc.vpc_id}"
  project_name = "${var.project_name}"
  project_env = "${var.project_env}"
  
}

