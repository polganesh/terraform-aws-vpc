###################------Gateway------#################
# Internet gateway 	:-	enable traffic with internet and vice a versa. available only if public subnets are available.
#######################################################
resource "aws_internet_gateway" "gw" {
  count  = length(var.public_subnet_cidr_list) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    var.tag_for_internet_gateway,
    {
      Name        = "igw-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
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

resource "aws_egress_only_internet_gateway" "egress_igw" {
  count  = var.create_egress_only_igw && var.enable_ipv6 && local.max_private_subnet_length > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    var.tag_for_egress_only_internet_gateway,
    {
      Name        = "eigw-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
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

