# work in progress
######################################################
# VPN Gateway
######################################################
#resource "aws_vpn_gateway" "main" {
#  vpc_id = aws_vpc.main.id
#  tags = merge(
#    var.common_tags,
#    var.tag_for_vpn_gateway,
#    {
#      Name        = "vpngw-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
#      RegionId    = var.region_id
#      Environment = var.environment
#      CostCentre  = var.cost_centre
#      VPCSeqId    = var.vpc_seq_id
#      VersionId   = var.version_id
#      BuildDate   = var.build_date
#      AppRole     = "network"
#    }
#  )
#
#}