data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name           = "vpc-example-staging"
  cidr           = "10.1.0.0/16"
  azs            = data.aws_availability_zones.available.names
  public_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

}
