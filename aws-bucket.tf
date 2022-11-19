module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v3.6.0"

  bucket = "br-o-bro"
  acl    = "private"

  versioning = {
    enabled = true
  }

  tags = local.tags
}
