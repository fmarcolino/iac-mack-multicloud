module "jenkins_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "jenkins-server"
  description = "Security group for Jenkins EC2 instance"
  vpc_id      = module.aws-vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-8080-tcp", "all-icmp", "ssh-tcp", ]
  egress_rules        = ["all-all"]

  tags = local.tags
}
