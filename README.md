# Managing AWS IAM Assume Role [ terraform-aws-iam-assume-role ]

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a27b392189174e6182993651f64925f6)](https://app.codacy.com/gh/anthunt/terraform-aws-iam-assume-role?utm_source=github.com&utm_medium=referral&utm_content=anthunt/terraform-aws-iam-assume-role&utm_campaign=Badge_Grade)
[![Terraform](https://img.shields.io/badge/Terraform-Registry:lastest-blue.svg)](https://registry.terraform.io/modules/anthunt/iam-assume-role/aws)

[toc]

## 1. tfvars Sample
> ```terraform
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

> ```terraform
>module "iam-policy" {
>   source      = "anthunt/iam-assume-role/aws"
>   version     = "0.0.1"
>   aws         = var.aws
>   assumeRole  = var.assumeRole
>}
> ```

## 3. variables.tf Example

>```terraform
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