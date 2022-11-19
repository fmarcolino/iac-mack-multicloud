module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.1"

  key_name   = "mackenzie"
  public_key = trimspace(tls_private_key.this.public_key_openssh)

  tags = local.tags
}
