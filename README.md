## README #

## Purpose of this Module
Although currently one can find various terraform modules to provision **AWS VPC**  this module mainly concentrate on
- How to avoid providing cumbersome vpcid, subnet id when creating various AWS resources?
- Make AWS resources more readable when navigating in AWS console. This became  more useful when your AWS account become very huge and contains a huge amount of AWS services
- Apply simple strategies for creating resources and improve security. e.g. enforce RDS in private subnet, compute resources like ECS, EKS in private subnet

## Dependencies and Prerequisites
- Terraform version 0.12 and higher
- AWS account
- AWS CLI

## This module responsible for creating
|Subnets                         | Notes        |
| ------------                    | ------------ |
| Public Subnet                   | A place for running Load Balancers (Application, Classic, Network), API Gateway....               |
| Private subnet for computing    | A place for running Compute resources like AWS lambda, ElasticBeanstalk, EC2, ECS, EKS......      |
| Private subnet for persistence layer    | A place for running RDS, NoSQL, Elastic search               |

|Gateways                         | Notes        |
| ------------                    | ------------ |
| Nat Gateway                    |Responsible for Instances(EC2/Containers etc) in private subnet to communicate with the Internet but the reverse is not true.
Associate public/Elastic IP with each Nat Gateway |
| Internet Gateway                    |Provide a target in your VPC route tables for internet-routable traffic.
Perform network address translation (NAT) for instances that have been assigned public IPv4 addresses |
| VPN Gateway                    |Enable the on-premises network to connect to this VPC|

| AWS Resource                    | Notes  |
| ------------                    | ------------ |
|Single VPC                       |             |
|Route and Route tables           |             |

## Example
```
module "vpc" {
source="git::https://github.com/polganesh/terraform-aws-vpc.git"
vpc_cidr_block = "10.10.0.0/16"
public_subnet_cidr_list = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
private_app_subnet_list = ["10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
private_db_subnet_list = ["10.10.7.0/24", "10.10.8.0/24", "10.10.9.0/24"]
region = "eu-central-1"
region_id = "euc1"
az_list = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
vpc_seq_id = "001"
seq_id = "001"
environment = "n"
cost_centre = "tech"
build_date = "30092019"
version_id = "001"
}
```

### AWS Resources created
| VPC                         |                                                         |
|---------------------------- | --------------------------------------------------------|
| VPC name format             | vpc-{region-id}-{environment}-{cost_centre}-{vpc_seq_id}|
|Example                      | vpc-euc1-n-tech-001                                     |
|Important Notes              | helpful for anyone to identify this VPC created in eu-central-1, for non prod account, cost for any resources created in this VPC will be managed by tech business unit in organization, it is first VPC in this AWS account with remaining combination                                                                             |


| Subnets             |                                                         |
|-------------------- | --------------------------------------------------------|
|Subnet name format   |sub-{region-id}-{environment}-{cost_centre}-vpc{vpc_seq_id}-{pub,privApp,privDb}-{az-indicator}-{seq_id}|
|Example for public subnets|sub-euc1-n-tech-vpc001-pub-1a-001                   |
|                     |sub-euc1-n-tech-vpc001-pub-1b-001                        |
|                     |sub-euc1-n-tech-vpc001-pub-1c-001                        |
|Example for private App subnets|sub-euc1-n-tech-vpc001-privApp-1a-001          |
|                     |sub-euc1-n-tech-vpc001-privApp-1b-001                    |
|                     |sub-euc1-n-tech-vpc001-privApp-1c-001                    |
|Example for private Db subnets|sub-euc1-n-tech-vpc001-privDb-1a-001          |
|                     |sub-euc1-n-tech-vpc001-privDb-1b-001                    |
|                     |sub-euc1-n-tech-vpc001-privDb-1c-001                    |

| Route Tables        |                                                         |
|-------------------- | --------------------------------------------------------|
|Route table format   |rtb-{region-id}-{environment}-{cost_centre}-vpc{vpc_seq_id}-{pub,privApp,privDb}-{az-indicator}-{seq_id}|
|Example for route tables|rtb-euc1-n-tech-vpc001-pub-1a-001                  |
||rtb-euc1-n-tech-vpc001-pub-1b-001                  |
||rtb-euc1-n-tech-vpc001-pub-1c-001                  |
||rtb-euc1-n-tech-vpc001-privApp-1a-001              |
||rtb-euc1-n-tech-vpc001-privApp-1b-001              |
||rtb-euc1-n-tech-vpc001-privApp-1c-001              |
||rtb-euc1-n-tech-vpc001-privDb-1a-001              |
||rtb-euc1-n-tech-vpc001-privDb-1b-001              |
||rtb-euc1-n-tech-vpc001-privDb-1c-001              |


| Nat Gateways        |                                                         |
|-------------------- | --------------------------------------------------------|
|Nat Gateway format   |ngw-{region-id}-{environment}-{cost_centre}-vpc{vpc_seq_id}-{az-indicator}-{seq_id}|
||ngw-euc1-n-tech-vpc001-1a-001|
||ngw-euc1-n-tech-vpc001-1b-001|
||ngw-euc1-n-tech-vpc001-1c-001|

| VPN Gateway        |                                                         |
|-------------------- | --------------------------------------------------------|
|VPN Gateway format   |vpngw-{region-id}-{environment}-{cost_centre}-{seq_id}|
||vpngw-euc1-n-tech-001|

| Internet Gateway        |                                                         |
|-------------------- | --------------------------------------------------------|
|Internet Gateway format   |igw-{region-id}-{environment}-{cost_centre}-{seq_id}|
||igw-euc1-n-tech-001|
	




