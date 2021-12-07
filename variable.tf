variable "environment" {
  description = "indicates name of our environment. possible values dev,cit,sit,uat,pprod,prod,n"
  default     = "dev"
}
variable "cost_centre" {
  description = "A part of an organization to which costs may be charged.e.g. finance/it/hr/wholesale/retail/investment etc..."
  default     = "na"
}
variable "vpc_cidr_block" {}
variable "vpc_instance_tenancy" {
  default     = "default"
  description = "possible values default or dedicated"
}
variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
  default     = false
}

variable "region_id" {
  default = "euw1"
}
variable "region" {
  description = "region in which resource is created."
  default     = "eu-west-1"
}
variable "version_id" {
  description = "version of this component.everytime when we are updating this component we need to increment it."
  default     = "1"
}
variable "build_date" {
  description = "date on which this component built/modified. format ddmmyyyy e.g. 27122017"
  default     = ""
}
variable "vpc_seq_id" {
  default = "001"
}
variable "public_subnet_cidr_list" {
  description = "all public facing resources e.g. ALB will reside in this subnet"
  type        = list(any)
  default     = []
}

variable "public_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 public subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
  default     = []
}

variable "private_app_subnet_list" {
  description = "all backend micro services ECS/K8s etc will receive request from this."
  type        = list(any)
  default     = []
}

variable "private_app_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 private app subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
  default     = []
}

variable "private_db_subnet_list" {
  description = "all noSQL, RDS etc will reside here"
  type        = list(any)
  default     = []
}

variable "private_db_subnet_ipv6_prefixes" {
  description = "Assigns IPv6 private db subnet id based on the Amazon provided /56 prefix base 10 integer (0-256). Must be of equal length to the corresponding IPv4 subnet list"
  type        = list(string)
  default     = []
}

variable "az_list" {
  type    = list(any)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "seq_id" {}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
  default     = []
}

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
  default     = false
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  description = "Specify a list of NTP servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_name_servers" {
  description = "Specify a list of netbios servers for DHCP options set (requires enable_dhcp_options set to true)"
  type        = list(string)
  default     = []
}

variable "dhcp_options_netbios_node_type" {
  description = "Specify netbios node_type for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "create_egress_only_igw" {
  description = "Controls if an Egress Only Internet Gateway is created and its related routes."
  type        = bool
  default     = true
}

variable "tag_for_vpc" {
  type    = map(any)
  default = {}
}
variable "tag_for_public_subnet" {
  type    = map(any)
  default = {}
}
variable "tag_for_privApp_subnet" {
  type    = map(any)
  default = {}
}
variable "tag_for_privDb_subnet" {
  type    = map(any)
  default = {}
}

variable "tag_for_internet_gateway" {
  type    = map(any)
  default = {}
}

variable "tag_for_egress_only_internet_gateway" {
  type    = map(any)
  default = {}
}

variable "tag_for_nat_gateway" {
  type    = map(any)
  default = {}
}
variable "tag_for_vpn_gateway" {
  type    = map(any)
  default = {}
}
variable "common_tags" {
  type    = map(any)
  default = {}
}
variable "tag_for_route_table" {
  type    = map(any)
  default = {}
}

variable "tag_for_dhcp" {
  type    = map(any)
  default = {}
}

variable "timeout_for_resource_creation" {
  default = "5m"
}

variable "timeout_for_resource_delete" {
  default = "5m"
}

variable "public_subnet_assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on public subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
  default     = false
}

variable "private_app_subnet_assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on private app subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
  default     = null
}

variable "private_db_subnet_assign_ipv6_address_on_creation" {
  description = "Assign IPv6 address on private db subnet, must be disabled to change IPv6 CIDRs. This is the IPv6 equivalent of map_public_ip_on_launch"
  type        = bool
  default     = null
}


