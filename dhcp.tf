resource "aws_vpc_dhcp_options" "main" {
  count                = var.enable_dhcp_options ? 1 : 0
  domain_name          = var.dhcp_options_domain_name
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = merge(
    var.common_tags,
    var.tag_for_dhcp,
    {
      Name        = "dhcp-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
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

resource "aws_vpc_dhcp_options_association" "main" {
  count           = var.enable_dhcp_options ? 1 : 0
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main[0].id
}