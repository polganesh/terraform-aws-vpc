######################################################
# Route table and route association
######################################################
resource "aws_route_table" "public" {
  vpc_id           = aws_vpc.main.id
  count            = length(var.public_subnet_cidr_list)
  propagating_vgws = [aws_vpn_gateway.main.id]

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

resource "aws_route" "public" {
  count                  = length(var.public_subnet_cidr_list)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

#------private app
resource "aws_route_table" "privateApp" {
  vpc_id           = aws_vpc.main.id
  count            = length(var.private_app_subnet_list)
  propagating_vgws = [aws_vpn_gateway.main.id]

  tags = merge(
    var.common_tags,
    var.tag_for_route_table,
    {
      Name        = "rtb-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-privApp-${element(split("-", element(var.az_list, count.index)), 2)}-${var.seq_id}"
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

resource "aws_route" "privateApp" {
  count                  = length(var.private_app_subnet_list)
  route_table_id         = element(aws_route_table.privateApp.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

#------private db
resource "aws_route_table" "privateDb" {
  vpc_id           = aws_vpc.main.id
  count            = length(var.private_db_subnet_list)
  propagating_vgws = [aws_vpn_gateway.main.id]
  tags = merge(
    var.common_tags,
    var.tag_for_route_table,
    {
      Name        = "rtb-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-privDb-${element(split("-", element(var.az_list, count.index)), 2)}-${var.seq_id}"
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

resource "aws_route" "privateDb" {
  count                  = length(var.private_db_subnet_list)
  route_table_id         = element(aws_route_table.privateDb.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

#--------route table associatation with subnet
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr_list)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route_table_association" "privateApp" {
  count          = length(var.private_app_subnet_list)
  subnet_id      = element(aws_subnet.privApp.*.id, count.index)
  route_table_id = element(aws_route_table.privateApp.*.id, count.index)
}

resource "aws_route_table_association" "privateDb" {
  count          = length(var.private_db_subnet_list)
  subnet_id      = element(aws_subnet.privDb.*.id, count.index)
  route_table_id = element(aws_route_table.privateDb.*.id, count.index)
}