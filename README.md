## README #

## Purpose of this Module
Although  one can find various terraform modules to provision **AWS VPC**. 
This module mainly concentrate on
+ How to avoid providing cumbersome vpcid, subnet id when creating various AWS resources?
+ Make AWS resources more readable when navigating in AWS console. This became  more useful when your AWS account has lot of resources.
+ Apply simple strategies for creating resources and improve security. e.g. enforce RDS in private subnet, compute resources like ECS, EKS in private subnet.This become very useful when this module used by novice developer.
+ Attach predefined tags to AWS resources. These tags play major role in tracking resources for
  * Monitoring. tools like Datadog depends heavily on tags
  * Cost 

## Dependencies and Prerequisites
- Terraform version 0.12 and higher
- AWS account
- AWS CLI

## Important Variables
|variable name                         	|is required	|Default Value	|Type	| Notes       	 		                     |
|:--------------------------------------|:--------------|:------------	|:---	|:---------------------------------------------------|
|vpc_cidr_block				|Y		|		|String	|Valid CIDR Range	                             |
|public_subnet_cidr_list		|N		|empty list	|list	| Valid list of CIDR range inline with vpc_cidr_block|
|private_app_subnet_list		|N		|empty list	|list	| Valid list of CIDR range inline with vpc_cidr_block|
|private_db_subnet_list			|N		|empty list	|list	| Valid list of CIDR range inline with vpc_cidr_block|
|region					|N		|eu-west-1	|string	| Valid AWS Region|
|region_id				|N		|euw1		|string	| Region Identifier. for more information about this please refer following sections|
|az_list				|N		|eu-west-1a,eu-west-1b, eu-west-1c|list	|Define Az in which subnet to be get created. Availability zone inline with region.it's count must be same as cidr ranges define for subnets. |
|vpc_seq_id				|N		|001|string	|Define sequence for combination of regionId,cost_centre and environment. one can define any random string,but it is better if is sequential number |
|seq_id				|N		|001|string	|usually some sequential number. in this case it should be same as vpc_seq_id |
|environment				|N		|dev|string	|indicates name of our environment.it can be anything. Possible values dev,cit,sit,uat,pprod,prod,n. for more information refer following sections.|
|cost_centre				|N		|na|string	|A part of an organization to which bill might be charged.e.g. finance/it/hr/wholesale/retail/investment etc...|

for complete list of variables please refer variables.tf of this module.

### region
* Indicates region in which VPC to be created.
* Possible values :- https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
* e.g. for Europe ireland :- eu-west-1

### region_id
* short indicator for region
* it can be  max 5 char.
* for **eu**-**w**est-1 it is **euw1**
* for **ap**-**s**outh**e**ast-1, singapore i.e. apse1	
* please note these are indicator for ideal region_id. one can use its own standard if needed.

### cost_centre
* It represents an entity which will own cost for resources created in this VPC .
* Any org can have multiple departments wfollowing cost centres. following values are indicative.one can use their own indicator,but one need to follow same throughout.
* all small case letters
* length 1 to 4 chars

Possible Cost Centres	|value
---------------------	|----
admin			|admn|
infrastructure		|infra|
techsupport		|tsup|
hr			|hr|
it			|it|
legal			|lgl|
finance			|fin|
wholesale		|whsl|
retail			|rtl|
manufacturing		|mfg|
banking			|bank|
investment		|inv|
marketing		|mkt|

### environment
* It represents the environment for which this VPC created for. 
* length 1 to 3 chars
* all small case letters
* Possible values

Value  | Important Note
------------- | -------------
dev  | 	for **Dev**elopment environment
cit  | 	specific to **C**omponent **I**ntegration **T**esting
sit  | 	specific to **S**ystem **I**ntegration **T**esting
uat  | 	specific to **U**ser **A**cceptance **T**esting
pre  | 	specific to **Pre**prod environment
n    |	VPC which is **not** for production env
p    |	VPC for **P**roduction environment


## Important Notes for Tags
This module add/override  following tags to various resources created.

|Tag Key   	| Variable 	|Notes												|
|:--------------|:--------------|:----------------------------------------------------------------------------------------------|
|RegionId  	|region_id 	|Represent indicator for region in which resource present					|
|Environment  	|environment 	|Represent Environment. 										|
|CostCentre  	|cost_centre 	|some predefined, unique identifier across org for identifying entity responsible for cost.	|
|VPCSeqId  	|vpc_seq_id 	|Indicator for VPC	|
|VersionId  	|version_id 	|it is less signficant,but if anyone want to track it is good idea|
|BuildDate  	|build_date 	|it is less signficant,but if someone wants to track date(predefine date format defined in your org) then it is good indicator for date on which this component/resource created/updated|
|AppRole  	| 	|it is constant with value **network** for various resources created by this module.|

## This module responsible for creating
|Subnets                         	| Notes        |
|:--------------------------------------|:------------ |
| Public Subnet                   	| Ideal  for running Load Balancers (Application, Classic, Network), API Gateway....               |
| Private subnet for **Computing**      |Ideal for running Compute resources like AWS lambda, ElasticBeanstalk, EC2, ECS, EKS......      |
| Private subnet for **Persistence layer**	| A place for running RDS, NoSQL, Elastic search  ....             |

|Gateways                         	| Notes        |
|:--------------------------------------|:------------ |
| Nat Gateway                    	|  Responsible for Instances(EC2/Containers etc) in private subnet to communicate with the 							Internet but the reverse is not true. Associate public/Elastic IP with each Nat Gateway|
| Internet Gateway                    	|  Provide a target in your VPC route tables for internet-routable traffic. Perform network address translation (NAT) for instances that have been assigned public IPv4 addresses |
| VPN Gateway                    	|Enable the on-premises network to connect to this VPC|

| AWS Resource           | Notes       |
|:-----------------------|:------------|
|Single VPC              |             |
|Route and Route tables  |             |

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

### AWS Resources created by this script
| VPC                         |                                                         |
|:---------------------------- |:--------------------------------------------------------|
| VPC name format             | vpc-{region-id}-{environment}-{cost_centre}-{vpc_seq_id}|
|Example                      | vpc-euc1-n-tech-001                                     |
|Important Notes              | helpful for anyone to identify this VPC created in eu-central-1, for non prod account, cost for any resources created in this VPC will be managed by tech business unit in organization, it is first VPC in this AWS account with remaining combination                                                                             |


| Subnets             |                                                         |
|:-------------------- |:--------------------------------------------------------|
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
|:-------------------- |:--------------------------------------------------------|
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
|:-------------------- |:--------------------------------------------------------|
|Nat Gateway format   |ngw-{region-id}-{environment}-{cost_centre}-vpc{vpc_seq_id}-{az-indicator}-{seq_id}|
||ngw-euc1-n-tech-vpc001-1a-001|
||ngw-euc1-n-tech-vpc001-1b-001|
||ngw-euc1-n-tech-vpc001-1c-001|

| VPN Gateway        |                                                         |
|:-------------------- |:--------------------------------------------------------|
|VPN Gateway format   |vpngw-{region-id}-{environment}-{cost_centre}-{seq_id}|
||vpngw-euc1-n-tech-001|

| Internet Gateway        |                                                         |
|:-------------------- |:--------------------------------------------------------|
|Internet Gateway format   |igw-{region-id}-{environment}-{cost_centre}-{seq_id}|
||igw-euc1-n-tech-001|
	




