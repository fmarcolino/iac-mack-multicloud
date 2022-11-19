module "php_server" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "v4.2.1"

  name = "php-server"

  ami                    = data.aws_ami.linux2.image_id
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.php_sg.security_group_id]
  subnet_id              = module.aws-vpc.public_subnets[0]

  user_data_base64            = filebase64("${path.module}/user-datas/php-server.sh")
  user_data_replace_on_change = true

  tags = local.tags
}
