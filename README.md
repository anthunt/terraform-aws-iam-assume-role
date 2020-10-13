# Managing AWS IAM Assume Role [ terraform-aws-iam-assume-role ]

[toc]

## 1. tfvars Sample
> ```json
>   aws = {
>       "region" = "AWS Region ID"
>       "profile" = "AWS CLI Profile Name from ~/.aws/credentials or config"
>   }
> 
>   assumeRoles = {
> 
>       ASSUME-ROLE-NAME-01 = {
>           description = "Sample Assume Role for 01"
>           "trusted_arns" = [
>               "arn:aws:iam::[Assume Account ID]:root"
>           ]
>           "attach_policy_arns" = [
>               "Managed Policy ARN 01",
>               "Managed Policy ARN 02",
>               ...
>           ]
>           "inline_policies" = {}
>       } # End Of ASSUME-ROLE-NAME-01
> 
>       ASSUME-ROLE-NAME-02 = {
>           description = null
>           "trusted_arns" = [
>               "arn:aws:iam::[Assume Account ID]:root"
>           ]
>           "attach_policy_arns" = [
>               "Managed Policy ARN 01"
>           ]
>           "inline_policies" = {
>           "HLI-BU-USR-S3-VODAccess" = <<EOF
>       {
>           "Version": "2012-10-17",
>           "Statement": [
>               {
>                   "Effect": "Allow",
>                   "Action": [
>                       "s3:ListAllMyBuckets"
>                   ],
>                   "Resource": "*"
>               }
>           ]
>       }
>       EOF
>           } # End Of inline_policies
>       } # End Of ASSUME-ROLE-NAME-02
> 
>   } # End Of assumeRoles
>   ```

## 2. Module Usage

> ```bash
>module "iam-policy" {
>   source      = "anthunt/iam-assume-role/aws"
>   version     = "0.0.1"
>   aws         = var.aws
>   assumeRole  = var.assumeRole
>}
> ```

## 3. variables.tf Example

>```bash
> variable "aws" {
>     type = object({
>         region  = string
>         profile = string
>     })
> }
> 
> variable "assumeRoles" {
>     type = map(object({
>         description         = string
>         trusted_arns        = list(string)
>         attach_policy_arns  = list(string)
>         inline_policies     = map(string)
>     }))
> }
>```