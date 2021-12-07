######################################################
#   Route table and route association for public subnet
#       it will  create if public_subnet_cidr_list is provided
#       -   One public route table
#       -   Associate this route table with route  0.0.0.0/0
#       -   if ipv6 enabled then associate route table with route ::/0
#       -   finally associate this route table with all public subnets of VPC
#   Please note we are associating here internet gateway since it is public route table. For more info refer
#   aws_route.public_ipv6, aws_route.public and their attribute gateway_id
######################################################
resource "aws_route_table" "public" {
  count  = length(var.public_subnet_cidr_list)
  vpc_id = aws_vpc.main.id
  #propagating_vgws = [aws_vpn_gateway.main.id]
  tags = merge(
    var.common_tags,
    var.tag_for_route_table,
    {
      Name        = "rtb-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-pub-${element(split("-", element(var.az_list, count.index)), 2)}-${var.seq_id}"
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

resource "aws_route" "public_ipv6" {
  count                       = length(var.public_subnet_cidr_list) > 0 && var.enable_ipv6 ? length(var.public_subnet_cidr_list) : 0
  route_table_id              = element(aws_route_table.public.*.id, count.index)
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.gw[0].id
}

resource "aws_route" "public" {
  count                  = length(var.public_subnet_cidr_list)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw[0].id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr_list)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}