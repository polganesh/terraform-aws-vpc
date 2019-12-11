## README #

## Purpose of this Module
Although currently one can find various terraform modules to provision **AWS VPC**  this module mainly concentrate on
- How to avoid providing cumbersome vpcid, subnet id when creating various AWS resources?
- Make AWS resources more readable when navigating in AWS console. This became  more useful when your AWS account become very huge and contains a huge amount of AWS services
- Apply simple strategies for creating resources and improve security. e.g. enforce RDS in private subnet, compute resources like ECS, EKS in private subnet


