###################------Gateway------#################
# Nat gateway
#  This enable resources in private subnet communicate on internet but reverse is not true
#  Please note we will create
#   nat gateway in each public subnet.
#   we will assign elastic ip to each nat gateway.
#   total number of nat gateway =number of public subnets=elastic IP
#   i.e. we will create nat gateway in each public subnet
#######################################################

# these elastic Ip we will associate with nat gateway associated with each private subnet for app
resource "aws_eip" "main" {
  count = local.nat_gateway_count
  vpc   = true #indicates if this elastic ip in VPC
}

resource "aws_nat_gateway" "main" {
  count         = local.nat_gateway_count
  allocation_id = element(aws_eip.main.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  depends_on    = [aws_internet_gateway.gw]

  tags = merge(
    var.common_tags,
    var.tag_for_nat_gateway,
    {
      Name        = "ngw-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${element(split("-", element(var.az_list, count.index)), 2)}-${var.seq_id}"
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