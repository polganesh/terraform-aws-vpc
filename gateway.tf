###################------Gateway------#################
#Internet gateway 	:-	enable traffic with internet and viceaversa
#Nat gateway 		:-	enable resources in private subnet 
#						to communicate on internet 
#						but reverse is not true
#######################################################
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.common_tags,
    var.tag_for_internent_gateway,
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

# these elastic Ip we will associate with nat gateway associated with each private subnet for app
resource "aws_eip" "main" {
  count = length(var.private_app_subnet_list)
  vpc   = true #indicates if this elastic ip in VPC
}

# create nat gateway in each public subnet and allocate elastic ip to it.
# this will used for instances in private subnet to connect internet
resource "aws_nat_gateway" "main" {
  count         = length(var.private_app_subnet_list)
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

######################################################
# VPN Gateway
######################################################
resource "aws_vpn_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.tag_for_vpn_gateway,
    {
      Name        = "vpngw-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}"
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