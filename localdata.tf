locals {
  max_private_subnet_length = max(length(var.private_app_subnet_list), length(var.private_db_subnet_list))
  nat_gateway_count = local.max_private_subnet_length
  az_set                    = toset(var.az_list)
}
