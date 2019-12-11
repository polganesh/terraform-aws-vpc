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





