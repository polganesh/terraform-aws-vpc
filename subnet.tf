resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidr_list, count.index)
  count                   = length(var.public_subnet_cidr_list)
  availability_zone       = element(var.az_list, count.index)
  map_public_ip_on_launch = "true"

  tags = merge(
    var.common_tags,
    var.tag_for_public_subnet,
    {
      Name        = "sub-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-pub-${element(split("-", element(var.az_list, count.index)), 2)}-${var.seq_id}"
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

resource "aws_subnet" "privApp" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_app_subnet_list, count.index)
  count             = length(var.private_app_subnet_list)
  availability_zone = element(var.az_list, count.index)

  tags = merge(
    var.common_tags,
    var.tag_for_privApp_subnet,
    {
      Name        = "sub-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-privApp-${element(split("-", element(var.az_list, count.index)), 2)}-${var.seq_id}"
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

resource "aws_subnet" "privDb" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_db_subnet_list, count.index)
  count             = length(var.private_db_subnet_list)
  availability_zone = element(var.az_list, count.index)
  tags = merge(
    var.common_tags,
    var.tag_for_privDb_subnet,
    {
      Name        = "sub-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-privDb-${element(split("-", element(var.az_list, count.index)), 2)}-${var.seq_id}"
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