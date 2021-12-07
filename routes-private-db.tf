resource "aws_route_table" "privateDb" {
  count  = length(var.private_db_subnet_list)
  vpc_id = aws_vpc.main.id
  #propagating_vgws = [aws_vpn_gateway.main.id]
  tags = merge(
    var.common_tags,
    var.tag_for_route_table,
    {
      Name        = "rtb-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${element(split("-", element(var.az_list, count.index)), 2)}-privDb-${var.seq_id}"
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
  timeouts {
    create = var.timeout_for_resource_creation
    delete = var.timeout_for_resource_delete
  }
}


resource "aws_route" "privateDb_ipv6_egress" {
  # we will enable ipv6 routes  only if we enable ipv6.
  # currently we create
  #   one route table if private_app_subnet_list >0 and
  #   one aws_egress_only_internet_gateway
  count                       = var.enable_ipv6 && length(var.private_db_subnet_list) > 0 ? length(var.private_db_subnet_list) : 0
  route_table_id              = element(aws_route_table.privateDb.*.id, count.index)
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.egress_igw[0].id
  timeouts {
    create = var.timeout_for_resource_creation
    delete = var.timeout_for_resource_delete
  }
}

resource "aws_route_table_association" "privateDb" {
  count          = length(var.private_db_subnet_list) > 0 ? length(var.private_db_subnet_list) : 0
  subnet_id      = element(aws_subnet.privDb.*.id, count.index)
  route_table_id = element(aws_route_table.privateDb.*.id, count.index)
}


