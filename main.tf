
module "vpc" {
    source = "git::https://github.com/challasrikanth/terraform-aws-webapp.git//modules/vpc"
    project = var.project
    environment = var.environment

}


module "alb" {
  source         = "git::https://github.com/challasrikanth/terraform-aws-webapp.git//modules/alb"
  public_subnets = module.vpc.public_subnet_ids
  vpc_id         = module.vpc.vpc_id
}

module "ec2_asg" {
  source           = "git::https://github.com/challasrikanth/terraform-aws-webapp.git//modules/asg"
  ami              = var.ami
  instance_type    = var.instance_type
  private_subnets  = module.vpc.private_subnet_ids
  target_group_arn = module.alb.target_group_arn
}
