output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.main.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.main.*.arn, [""])[0]
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.main.*.cidr_block, [""])[0]
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = concat(aws_vpc.main.*.instance_tenancy, [""])[0]
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = concat(aws_vpc.main.*.enable_dns_support, [""])[0]
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = concat(aws_vpc.main.*.enable_dns_hostnames, [""])[0]
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = concat(aws_vpc.main.*.ipv6_association_id, [""])[0]
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block"
  value       = concat(aws_vpc.main.*.ipv6_cidr_block, [""])[0]
}

output "vpc_secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks of the VPC"
  value       = aws_vpc_ipv4_cidr_block_association.main.*.cidr_block
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = concat(aws_vpc.main.*.owner_id, [""])[0]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}

output "private_app_subnets" {
  description = "List of IDs of private app subnets"
  value       = aws_subnet.privApp.*.id
}

output "private_db_subnets" {
  description = "List of IDs of private db subnets"
  value       = aws_subnet.privDb.*.id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public.*.arn
}

output "private_app_subnet_arns" {
  description = "List of ARNs of private app subnets"
  value       = aws_subnet.privApp.*.arn
}

output "private_db_subnet_arns" {
  description = "List of ARNs of private db subnets"
  value       = aws_subnet.privDb.*.arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.public.*.cidr_block
}

output "private_app_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private app subnets"
  value       = aws_subnet.privApp.*.cidr_block
}

output "private_db_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private db subnets"
  value       = aws_subnet.privDb.*.cidr_block
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = aws_subnet.public.*.ipv6_cidr_block
}

output "private_app_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private app  subnets in an IPv6 enabled VPC"
  value       = aws_subnet.privApp.*.ipv6_cidr_block
}

output "private_db_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private db  subnets in an IPv6 enabled VPC"
  value       = aws_subnet.privDb.*.ipv6_cidr_block
}

output "public_route_table_ids" {
  description = "List of IDs of route tables for public subnet"
  value       = aws_route_table.public.*.id
}

output "private_app_route_table_ids" {
  description = "List of IDs of route tables for private app subnet"
  value       = aws_route_table.privateApp.*.id
}

output "private_db_route_table_ids" {
  description = "List of IDs of route tables for private db subnet"
  value       = aws_route_table.privateDb.*.id
}

output "dhcp_options_id" {
  description = "The ID of the DHCP options"
  value       = concat(aws_vpc_dhcp_options.main.*.id, [""])[0]
}

output "nat_eip_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.main.*.id
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.main.*.id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = concat(aws_internet_gateway.gw.*.id, [""])[0]
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = concat(aws_internet_gateway.gw.*.arn, [""])[0]
}

output "egress_only_internet_gateway_id" {
  description = "The ID of the egress only Internet Gateway"
  value       = concat(aws_egress_only_internet_gateway.egress_igw.*.id, [""])[0]
}



