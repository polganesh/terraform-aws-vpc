/**
Module Name :- Amazon VPC
Description	:- General Purpose VPC. for more information and how to use this module refer readme file for this.
**/
resource "aws_vpc" "main" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = var.vpc_instance_tenancy
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support

  tags = merge(
    var.common_tags,
    var.tag_for_vpc,
    {
      Name        = "vpc-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
      RegionId    = var.region_id
      Environment = var.environment
      CostCentre  = var.cost_centre
      VPCSeqId    = var.vpc_seq_id
      VersionId   = var.version_id
      BuildDate   = var.build_date
      AppRole     = "network"
    }
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "main" {
  count      = length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.secondary_cidr_blocks, count.index)
}

